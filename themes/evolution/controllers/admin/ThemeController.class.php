<?php

namespace Themes\Evolution\Controllers\Admin;

use App\Core\Database;
use App\Models\Theme;
use App\Controllers\Admin\ThemeController AS CoreThemeController;
use App\Helpers\AdminHelper;
use App\Helpers\CoreHelper;
use App\Helpers\ThemeHelper;

class ThemeController extends CoreThemeController
{
    public function themeSettings() {
        // admin restrictions
        $this->restrictAdminAccess();
        
        // pickup request
        $db = Database::getDatabase();
        $request = $this->getRequest();

        // load themes details
        $themeFolder = basename(dirname(dirname(__DIR__)));
        $themes = $db->getRow("SELECT * "
                . "FROM theme "
                . "WHERE folder_name = :folder_name "
                . "LIMIT 1", array(
                    'folder_name' => $themeFolder,
                ));
        if (!$themes) {
            return $this->redirect(ADMIN_WEB_ROOT . '/theme_manage?error=' . urlencode('There was a problem loading the theme details.'));
        }

        // load themes details
        $themeObj = ThemeHelper::getInstance($themes['folder_name']);
        $themeDetails = ThemeHelper::themeSpecificConfiguration($themes['folder_name']);
        $themeConfig = $themeDetails['config'];

        // pre-load all site skins
        $skinsPath = dirname(dirname(__DIR__)).'/assets/styles/skins/';
        $skins = CoreHelper::getDirectoryListing($skinsPath);
        sort($skins);

        // prep into array
        $skinsArr = array();
        foreach($skins AS $option) {
            $skinsArr[] = str_replace($skinsPath, '', $option);
        }

        // load existing settings
        if (strlen($themes['theme_settings'])) {
            $theme_settings = json_decode($themes['theme_settings'], true);
            if ($theme_settings) {
                $site_skin = $theme_settings['site_skin'];
                $css_code = $theme_settings['css_code'];
            }
        }

        // make sure the logo directory path exists
        $logoStorageFolder = CACHE_DIRECTORY_ROOT . '/themes/' . $themeFolder;
        $logoStorageUrl = CACHE_WEB_ROOT . '/themes/' . $themeFolder;
        if (!file_exists($logoStorageFolder)) {
            mkdir($logoStorageFolder, 0777, true);
        }

        // handle page submissions
        if($request->request->has('submitted')) {
            // get variables
            $site_skin = $request->request->get('site_skin');
            $css_code = $request->request->get('css_code');

            // validate submission
            if (CoreHelper::inDemoMode() == true) {
                AdminHelper::setError(AdminHelper::t("no_changes_in_demo_mode"));
            }

            if (AdminHelper::isErrors() == false) {
                if ($request->files->has('site_logo') && strlen($request->files->get('site_logo')['tmp_name'])) {
                    // check it's an image
                    if (exif_imagetype($request->files->get('site_logo')['tmp_name']) != IMAGETYPE_PNG) {
                        AdminHelper::setError('Logo does not appear to be a PNG image. Please check and try again.');
                    }
                    elseif ($request->files->get('site_logo')['size'] > 200000) {
                        AdminHelper::setError('Logo is bigger than 200k in size, please reduce and try again.');
                    }
                }

                if ($request->files->has('site_logo_inverted') && strlen($request->files->get('site_logo_inverted')['tmp_name'])) {
                    // check it's an image
                    if (exif_imagetype($request->files->get('site_logo_inverted')['tmp_name']) != IMAGETYPE_PNG) {
                        AdminHelper::setError('Logo does not appear to be a PNG image. Please check and try again.');
                    }
                    elseif ($request->files->get('site_logo_inverted')['size'] > 200000) {
                        AdminHelper::setError('Logo is bigger than 200k in size, please reduce and try again.');
                    }
                }
            }

            // update the settings
            if (AdminHelper::isErrors() == false) {
                // compile new settings
                $settingsArr = array();
                $settingsArr['thumbnail_type'] = 'square';
                $settingsArr['site_skin'] = $site_skin;
                $settingsArr['css_code'] = $css_code;
                $settings = json_encode($settingsArr);

                // update
                $theme = Theme::loadOneById($themes['id']);
                $theme->theme_settings = $settings;
                $theme->save();

                // move logo into storage
                if ($request->files->has('site_logo') && strlen($request->files->get('site_logo')['tmp_name'])) {
                    $targetFile = $logoStorageFolder . '/logo.png';
                    move_uploaded_file($request->files->get('site_logo')['tmp_name'], $targetFile);
                }

                if ($request->files->has('site_logo_inverted') && strlen($request->files->get('site_logo_inverted')['tmp_name'])) {
                    $targetFile = $logoStorageFolder . '/logo_inverse.png';
                    move_uploaded_file($request->files->get('site_logo_inverted')['tmp_name'], $targetFile);
                }

                // create custom css file
                $cssCodeFile = CACHE_DIRECTORY_ROOT . '/themes/' . $themeFolder . '/custom_css.css';
                if (strlen($settingsArr['css_code'])) {
                    file_put_contents($cssCodeFile, $settingsArr['css_code']);
                }
                else {
                    unlink($cssCodeFile);
                }

                // clear cache
                ThemeHelper::clearCachedThemeSettings();
                AdminHelper::setSuccess('Theme settings updated.');
            }
        }
        
        // load template
        return $this->render('admin/theme_settings.html', array_merge(array(
                    'mainLogoUrl' => $themeObj->getMainLogoUrl(),
                    'inverseLogoUrl' => $themeObj->getInverseLogoUrl(),
                    'skinsArr' => $skinsArr,
                    'css_code' => $css_code,
                    'site_skin' => $site_skin,
                                ), $this->getHeaderParams()));
    }

}
