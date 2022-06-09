<?php

namespace App\Controllers;

use App\Core\Database;
use App\Models\File;
use App\Models\FileFolder;
use App\Models\User;
use App\Helpers\AdvertisingHelper;
use App\Helpers\AuthHelper;
use App\Helpers\CoreHelper;
use App\Helpers\ChartsHelper;
use App\Helpers\FileHelper;
use App\Helpers\FileFolderHelper;
use App\Helpers\NotificationHelper;
use App\Helpers\PluginHelper;
use App\Helpers\UserHelper;
use App\Helpers\ThemeHelper;
use App\Helpers\TranslateHelper;
use App\Helpers\StatsHelper;
use App\Helpers\ValidationHelper;
use App\Services\ZipFile;

class AccountFileController extends AccountController
{

    public function ajaxGetAccountFileStats() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get params for later
        $Auth = $this->getAuth();

        // prepare result
        $result = array();

        // get total files in root folder
        $result['totalRootFiles'] = (int) FileHelper::getTotalActiveFilesByUserFolderId($Auth->user->id, null);

        // get total files in trash
        $result['totalTrashFiles'] = (int) $Auth->user->getTotalTrashFiles();

        // get total active files
        $result['totalActiveFiles'] = (int) $Auth->user->getTotalActiveFiles();
        $result['totalShareWithMeFiles'] = (int) $Auth->user->getTotalSharedWithMeFiles();

        // get total used space
        $result['totalActiveFileSize'] = $Auth->user->getTotalActiveFileSize();
        $result['totalFileStorage'] = UserHelper::getMaxFileStorage($Auth->id);
        $result['totalActiveFileSizeFormatted'] = CoreHelper::formatSize($result['totalActiveFileSize'], 'both', true, 1);
        $result['totalFileStorageFormatted'] = $result['totalFileStorage'] === null ? ucwords(TranslateHelper::t('unlimited', 'unlimited')) : CoreHelper::formatSize($result['totalFileStorage'], 'both', true, 1);
        $storagePercentage = 0;
        if ($result['totalActiveFileSize'] > 0 && (int) $result['totalFileStorage'] > 0) {
            $storagePercentage = ($result['totalActiveFileSize'] / $result['totalFileStorage']) * 100;
            if ($storagePercentage < 1) {
                $storagePercentage = 1;
            }
            else {
                $storagePercentage = floor($storagePercentage);
            }
        }
        $result['totalStoragePercentage'] = $storagePercentage;

        // get folder listing
        $folderListing = FileFolderHelper::loadAllActiveForSelect($Auth->id, '|||');
        $folderListingArr = array();
        foreach ($folderListing AS $k => $folderListingItem) {
            $folderListingArr[$k] = ValidationHelper::safeOutputToScreen($folderListingItem);
        }
        $result['folderArray'] = json_encode($folderListing);

        // create the drop-down select for the uploader
        $folderArr = FileFolderHelper::loadAllActiveForSelect($Auth->id);
        $html = '';
        $html .= '<select id="folder_id" name="folder_id" class="form-control">';
        $html .= '<option value="">' . TranslateHelper::t("index_default", "- default -") . '</option>';
        if (COUNT($folderArr)) {
            foreach ($folderArr AS $id => $folderLabel) {
                $html .= '<option value="' . (int) $id . '">' . ValidationHelper::safeOutputToScreen($folderLabel) . '</option>';
            }
        }
        $html .= '</select>';
        $result['folderSelectForUploader'] = $html;

        return $this->renderJson($result);
    }

    public function ajaxEditFile() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();
        $db = Database::getDatabase();

        // pickup request for later
        $request = $this->getRequest();

        // load file
        $file = File::loadOneById($request->request->get('fileId'));
        if (!$file) {
            // exit
            return $this->render404();
        }

        // make sure the logged in user owns this file
        if (!in_array($Auth->id, array($file->userId, $file->uploadedUserId))) {
            // exit
            return $this->render404();
        }

        // load folder structure as array
        $folderListing = FileFolderHelper::loadAllActiveForSelect($Auth->id, '/');
        
        // load user types for minimum user level
        $userTypes = $db->getRows('SELECT id, label '
                . 'FROM user_level '
                . 'WHERE level_type IN ("free", "paid") '
                . 'ORDER BY id ASC');

        // load template
        return $this->render('account/ajax/edit_file.html', array(
                    'file' => $file,
                    'folderListing' => $folderListing,
                    'userTypes' => $userTypes,
        ));
    }

    public function ajaxEditFileProcess() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();

        // pickup request for later
        $request = $this->getRequest();

        // load file
        $file = File::loadOneById($request->request->get('fileId'));
        if (!$file) {
            // exit
            return $this->render404();
        }

        // make sure the logged in user owns this file
        if (!in_array($Auth->id, array($file->userId, $file->uploadedUserId))) {
            // exit
            return $this->render404();
        }

        // load folder structure as array
        $folderListing = FileFolderHelper::loadAllActiveForSelect($Auth->id, '/', $file->folderId);

        // handle submission
        if ($request->request->has('submitme')) {
            // validation
            $filename = trim($request->request->get('filename'));
            $filename = strip_tags($filename);
            $filename = str_replace(array("'", "\""), "", $filename);
            $resetStats = (int) $request->request->get('reset_stats');
            $folder = (int) $request->request->get('folder');
            $keywords = trim($request->request->get('keywords'));
            $keywords = strip_tags($keywords);
            $keywords = str_replace(array("'", "\""), "", $keywords);
            $description = trim($request->request->get('description'));
            $description = strip_tags($description);
            $description = str_replace(array("\n", "\r"), " ", $description);
            $enablePassword = false;
            $accessPassword = null;
            if ($request->request->has('enable_password')) {
                $enablePassword = true;
                $accessPassword = trim($request->request->get('access_password'));
            }
            $min_user_level = strlen($request->request->get('min_user_level'))?(int)$request->request->get('min_user_level'):null;

            if (!strlen($filename)) {
                NotificationHelper::setError(TranslateHelper::t("please_enter_the_filename", "Please enter the filename"));
            }
            elseif (CoreHelper::inDemoMode() == true) {
                NotificationHelper::setError(TranslateHelper::t("no_changes_in_demo_mode"));
            }
            else {
                // check for files in same folder
                $foundExistingFile = (int) File::count('originalFilename = :originalFilename '
                                . 'AND status = "active" '
                                . 'AND folderId ' . ((int) $file->folderId > 0 ? ('=' . $file->folderId) : 'IS NULL') . ' '
                                . 'AND id != :id', array(
                            'originalFilename' => $filename . '.' . $file->extension,
                            'id' => $file->id,
                ));
                if ($foundExistingFile > 0) {
                    NotificationHelper::setError(TranslateHelper::t("active_file_with_same_name_found", "Active file with same name found in the same folder. Please ensure the file name is unique."));
                }
            }

            // no errors
            if (!NotificationHelper::isErrors()) {
                if ($folder === 0) {
                    $folder = null;
                }

                // update file
                $file->originalFilename = $filename . '.' . $file->extension;
                $file->folderId = $folder;
                $file->keywords = $keywords;
                $file->description = $description;

                // include password
                $passwordHash = '';
                if ($enablePassword === true) {
                    if ((strlen($accessPassword)) && ($accessPassword != '**********')) {
                        $passwordHash = md5($accessPassword);
                    }
                }
                else {
                    // remove existing password
                    $passwordHash = null;
                }

                if (($passwordHash === null) || (strlen($passwordHash))) {
                    $file->accessPassword = $passwordHash;
                }
                
                // update minimum account level
                $file->minUserLevel = $min_user_level;

                $file->save();

                // clean stats if needed
                if ($resetStats === 1) {
                    $file->deleteStats();
                }

                // clear preview cache
                $pluginObj = PluginHelper::getInstance('filepreviewer');
                if ($pluginObj) {
                    $pluginObj->deleteImagePreviewCache((int) $file->id);
                }

                // success
                NotificationHelper::setSuccess(TranslateHelper::t('file_item_updated', 'File updated.'));
            }
        }

        // prepare result
        $returnJson = array();
        $returnJson['success'] = false;
        $returnJson['msg'] = TranslateHelper::t("problem_updating_item", "There was a problem updating the item, please try again later.");
        if (NotificationHelper::isErrors()) {
            // error
            $returnJson['success'] = false;
            $returnJson['msg'] = implode('<br/>', NotificationHelper::getErrors());
        }
        else {
            // success
            $returnJson['success'] = true;
            $returnJson['msg'] = implode('<br/>', NotificationHelper::getSuccess());
        }

        // output response
        return $this->renderJson($returnJson);
    }

    public function ajaxFileStats() {
        // get the current logged in user
        $Auth = AuthHelper::getAuth();

        // pickup request for later
        $request = $this->getRequest();

        // load file
        $file = File::loadOneById($request->request->get('fileId'));
        if (!$file) {
            // exit
            return $this->render404();
        }

        // make sure user is permitted to view stats
        if ($file->canViewStats() == false) {
            // exit
            return $this->render404();
        }

        // last 24 hours chart
        $last24hours = ChartsHelper::createBarChart($file, 'last24hours');

        // last 7 days chart
        $last7days = ChartsHelper::createBarChart($file, 'last7days');

        // last 30 days chart
        $last30days = ChartsHelper::createBarChart($file, 'last30days');

        // last 12 months chart
        $last12months = ChartsHelper::createBarChart($file, 'last12months');

        // top countries pie
        $countries = ChartsHelper::createPieChart($file, 'countries');

        // top referrers pie
        $referrers = ChartsHelper::createPieChart($file, 'referrers');

        // top browsers pie
        $browsers = ChartsHelper::createPieChart($file, 'browsers');

        // top os pie
        $os = ChartsHelper::createPieChart($file, 'os');

        // load template
        return $this->render('account/ajax/file_stats.html', array(
                    'file' => $file,
                    'last24hours' => $last24hours,
                    'last7days' => $last7days,
                    'last30days' => $last30days,
                    'last12months' => $last12months,
                    'countries' => $countries,
                    'referrers' => $referrers,
                    'browsers' => $browsers,
                    'os' => $os,
        ));
    }

    public function ajaxFileDetails() {
        // get the current logged in user
        $Auth = AuthHelper::getAuth();
        $db = Database::getDatabase();

        // pickup request for later
        $request = $this->getRequest();

        // for failed auth
        $javascript = '';

        // load file
        $userOwnsFile = false;
        $folder = null;
        $shareAccessLevel = 'view';

        // require the file id
        if ($request->request->has('u') === false) {
            $returnJson = array();
            $returnJson['html'] = 'File not found.';
            $returnJson['javascript'] = 'window.location = "' . ThemeHelper::getLoadedInstance()->getAccountWebRoot() . '";';

            // output response
            return $this->renderJson($returnJson);
        }

        // attempt to load the file and exit if we fail
        $file = File::loadOneById($request->request->get('u'));
        if (!$file) {
            // failed lookup of file
            $returnJson = array();
            $returnJson['html'] = 'File not found.';
            $returnJson['javascript'] = 'window.location = "' . ThemeHelper::getAccountWebRoot() . '";';

            // output response
            return $this->renderJson($returnJson);
        }

        // load folder for later
        if ($file->folderId !== NULL) {
            $folder = $file->getFolderData();
        }

        if ($folder) {
            // setup permissions
            $showDownloadLink = (bool) $folder->showDownloadLinks;
            if ((int) $folder->userId) {
                // get folder owner details
                $owner = User::loadOneById($folder->userId);

                // store if the current user owns the folder
                if ($owner->id === $Auth->id) {
                    $userOwnsFolder = true;
                    $shareAccessLevel = 'all';
                }
                // check for folder downloads being enabled
                elseif ($folder->showDownloadLinks == 1) {
                    $shareAccessLevel = 'view_download';
                }

                // internally shared folders
                if ($Auth->loggedIn()) {
                    // setup access if user has been granted share access to the folder
                    $shareData = $db->getRow('SELECT file_folder_share.id, share_permission_level, access_key '
                            . 'FROM file_folder_share '
                            . 'LEFT JOIN file_folder_share_item ON file_folder_share.id = file_folder_share_item.file_folder_share_id '
                            . 'WHERE shared_with_user_id = :shared_with_user_id '
                            . 'AND folder_id = :folder_id '
                            . 'LIMIT 1', array(
                        'shared_with_user_id' => $Auth->id,
                        'folder_id' => $folder->id,
                    ));
                    if ($shareData) {
                        $db->query('UPDATE file_folder_share '
                                . 'SET last_accessed = NOW() '
                                . 'WHERE id = :id '
                                . 'LIMIT 1', array(
                            'id' => $shareData['id'],
                        ));
                        $_SESSION['sharekeyFolder' . $folder->id] = true;
                        $shareAccessLevel = $shareData['share_permission_level'];
                    }
                }
            }
        }
        else {
            // for root level files, show download link as we can't override it by folder
            $shareAccessLevel = 'view_download';
            $showDownloadLink = true;
        }

        // check current user has permission to view the file
        if (($file->userId != $Auth->id) && ($Auth->level_id < 10)) {
            // if this is a private file
            if (CoreHelper::getOverallPublicStatus($file->userId, $file->folderId, $file->id) == false) {
                // output response
                $returnJson['html'] = '<div class="ajax-error-image"><!-- --></div>';
                $returnJson['page_title'] = TranslateHelper::t('error', 'Error');
                $returnJson['page_url'] = '';
                $returnJson['javascript'] = 'showErrorNotification("' . str_replace("\"", "'", TranslateHelper::t('error', 'Error')) . '", "' . str_replace("\"", "'", TranslateHelper::t('file_is_not_publicly_shared_please_contact', 'File is not publicly shared. Please contact the owner and request they update the privacy settings.')) . '");';

                // output response
                return $this->renderJson($returnJson);
            }

            // check if folder needs a password
            if (($folder) && (strlen($folder->accessPassword) > 0)) {
                // see if we have it in the session already
                $askPassword = true;
                if (!isset($_SESSION['folderPassword'])) {
                    $_SESSION['folderPassword'] = array();
                }
                elseif (isset($_SESSION['folderPassword'][$folder->id])) {
                    if ($_SESSION['folderPassword'][$folder->id] == $folder->accessPassword) {
                        $askPassword = false;
                    }
                }

                if ($askPassword === true) {
                    // output response
                    $returnJson['html'] = '<div class="ajax-error-image"><!-- --></div><div id="albumPasswordModel" data-backdrop="static" data-keyboard="false" class="albumPasswordModel modal fade custom-width general-modal"><div class="modal-dialog"><div class="modal-content"><form id="folderPasswordForm" action="' . CoreHelper::getCoreSitePath() . '/ajax/folder_password_process" autocomplete="off" onSubmit="$(\'#password-submit-btn\').click(); return false;"><div class="modal-body">';

                    $returnJson['html'] .= '<div class="row">';
                    $returnJson['html'] .= '	<div class="col-md-4">';
                    $returnJson['html'] .= '		<div class="tile-title tile-orange"> <div class="icon"> <i class="glyphicon glyphicon-lock"></i> </div> <div class="title"> <h3>' . TranslateHelper::t('password_protected', 'Password Protected') . '</h3> <p></p> </div> </div>';
                    $returnJson['html'] .= '	</div>';
                    $returnJson['html'] .= '	<div class="col-md-8">';
                    $returnJson['html'] .= '		<h4>' . TranslateHelper::t('password_required', 'Password Required') . '</h4><hr style="margin-top: 5px;"/>';
                    $returnJson['html'] .= '		<div class="form-group">';
                    $returnJson['html'] .= '			<p>' . TranslateHelper::t('this_folder_has_a_password_set', 'This folder requires a password to gain access. Use the form below to enter the password, then click "unlock".') . '</p>';
                    $returnJson['html'] .= '		</div>';

                    $returnJson['html'] .= '		<div class="form-group">';
                    $returnJson['html'] .= '			<label for="folderName" class="control-label">' . UCWords(TranslateHelper::t('access_password', 'Access Password')) . ':</label>';
                    $returnJson['html'] .= '			<div class="input-grsoup">';
                    $returnJson['html'] .= '				<input type="password" name="folderPassword" id="folderPassword" class="form-control" placeholder="************"/>';
                    $returnJson['html'] .= '			</div>';
                    $returnJson['html'] .= '		</div>';
                    $returnJson['html'] .= '	</div>';
                    $returnJson['html'] .= '</div>';

                    $returnJson['html'] .= '</div><div class="modal-footer" style="margin-top: 0px;">';
                    $returnJson['html'] .= '<input type="hidden" value="' . (int) $folder->id . '" id="folderId" name="folderId"/>';
                    $returnJson['html'] .= '<input type="hidden" value="1" id="submitme" name="submitme"/>';
                    $returnJson['html'] .= '<button type="button" class="btn btn-default" data-dismiss="modal">' . TranslateHelper::t('cancel', 'Cancel') . '</button>';
                    $returnJson['html'] .= '<button type="button" class="btn btn-info" id="password-submit-btn" onClick="processAjaxForm(this, function() { $(\'.modal\').modal(\'hide\'); $(\'.modal-backdrop\').remove(); showFile(' . (int) $file->id . '); }); return false;">' . TranslateHelper::t('unlock', 'Unlock') . ' <i class="entypo-check"></i></button>';
                    $returnJson['html'] .= '</div></form></div></div></div>';
                    $returnJson['javascript'] = "jQuery('.albumPasswordModel').modal('show');";
                    $returnJson['page_title'] = $pageTitle;
                    $returnJson['page_url'] = $pageUrl;

                    // output response
                    return $this->renderJson($returnJson);
                }
            }
        }
        else {
            if ($Auth->loggedIn() && ($file->userId == $Auth->id || $file->uploadedUserId == $Auth->id)) {
                $userOwnsFile = true;
            }
        }

        // update stats
        $rs = StatsHelper::track($file);
        if ($rs) {
            $file->updateLastAccessed();
        }

        // load file meta data
        $imageWidth = 0;
        $imageHeight = 0;
        $imageRawData = '';
        $imageDateTaken = $file->uploadedDate;
        $foundMeta = false;
        $imageData = $db->getRow('SELECT width, height, raw_data, date_taken '
                . 'FROM plugin_filepreviewer_meta '
                . 'WHERE file_id = ' . (int) $file->id . ' '
                . 'LIMIT 1');
        if ($imageData) {
            $imageWidth = (int) $imageData['width'];
            $imageHeight = (int) $imageData['height'];
            $imageRawData = trim($imageData['raw_data']);
            $imageDateTaken = $imageData['date_taken'];
            $foundMeta = true;
        }

        // setup max sizes
        $maxImagePreviewWidth = 1100;
        $maxImagePreviewHeight = 800;
        if (($imageWidth > 0) && ($imageWidth < $maxImagePreviewWidth)) {
            $maxImagePreviewWidth = $imageWidth;
        }
        if (($imageHeight > 0) && ($imageHeight < $maxImagePreviewHeight)) {
            $maxImagePreviewHeight = $imageHeight;
        }

        // get filepreviewer object
        $filePreviewerObj = PluginHelper::getInstance('filepreviewer');

        $imageRawDataArr = array();
        if (strlen($imageRawData)) {
            $imageRawDataArr = json_decode($imageRawData, true);
            if (!$imageRawDataArr) {
                $imageRawDataArr = array();
            }

            // format in prep for the template
            if (count($imageRawDataArr)) {
                foreach ($imageRawDataArr AS $k => $imageRawDataItem) {
                    $imageRawDataArr[$k] = array(
                        'label' => $filePreviewerObj->formatExifName($k),
                        'value' => $imageRawDataItem,
                    );
                }
            }
        }

        // load filepreviewer plugin details
        $pluginDetails = PluginHelper::pluginSpecificConfiguration('filepreviewer');
        $pluginConfig = $pluginDetails['config'];
        $pluginSettings = json_decode($pluginDetails['data']['plugin_settings'], true);

        // load file type
        $generalFileType = 'download';
        if ($filePreviewerObj) {
            $generalFileType = $filePreviewerObj->getGeneralFileType($file);
        }

        // get folder details
        $coverId = null;
        if ($folder) {
            $coverData = FileFolderHelper::getFolderCoverData($folder->id);
            $coverId = $coverData['file_id'];
            $coverUniqueHash = $coverData['unique_hash'];
        }

        // get owner details
        $owner = null;
        if ((int) $file->userId) {
            $owner = User::loadOneById($file->userId);
        }

        // get next and previous file
        $similarImages = ThemeHelper::getLoadedInstance()->getSimilarFiles($file);
        $totalImages = count($similarImages);
        $prev = null;
        $next = null;
        if ($totalImages) {
            // find index of currently selected
            $selectedIndex = null;
            foreach ($similarImages AS $k => $similarImage) {
                if ($similarImage->id === $file->id) {
                    $selectedIndex = $k;
                }
            }

            if ((int) $selectedIndex >= 1) {
                $prev = $similarImages[$selectedIndex - 1]->id;
            }

            if ((int) $selectedIndex < ($totalImages - 1)) {
                $next = $similarImages[$selectedIndex + 1]->id;
            }
        }

        // public status
        $isPublic = 1;
        if (CoreHelper::getOverallPublicStatus($file->userId, $file->folderId, $file->id) == false) {
            $isPublic = 0;
        }

        // links
        $links = array();
        if ($userOwnsFile == true) {
            if ($file->status == 'active') {
                $links[] = '<button type="button" class="btn btn-default" data-dismiss="modal" onClick="showEditFileForm(' . (int) $file->id . '); return false;" title="" data-original-title="' . addslashes(UCWords(TranslateHelper::t('account_file_details_edit_file', 'Edit File'))) . '" data-placement="bottom" data-toggle="tooltip"><i class="entypo-pencil"></i></button>';
                $links[] = '<button type="button" class="btn btn-default" data-dismiss="modal" onClick="deleteFile(' . (int) $file->id . ', function() {loadImages(\'folder\', ' . ((int) $file->folderId ? $file->folderId : '-1') . ');}); return false;" title="" data-original-title="' . addslashes(UCWords(TranslateHelper::t('account_file_details_delete_file', 'Delete File'))) . '" data-placement="bottom" data-toggle="tooltip"><i class="entypo-trash"></i></button>';
            }

            // make sure user is permitted to view stats
            if ($file->canViewStats() == true) {
                $links[] = '<button type="button" class="btn btn-default" onClick="showStatsPopup(\'' . $file->id . '\'); return false;" title="" data-original-title="' . addslashes(UCWords(TranslateHelper::t('account_file_details_file_stats', 'File Stats'))) . '" data-placement="bottom" data-toggle="tooltip"><i class="entypo-chart-line"></i></button>';
            }
        }

        // should we show the download link
        if ($userOwnsFile == true || $Auth->isAdmin() === true) {
            // override if this user owns the file
            $showDownloadLink = true;
        }
        elseif ($shareAccessLevel == 'view') {
            $showDownloadLink = false;
        }

        if (($file->status == 'active') && ($showDownloadLink == true)) {
            // copy to account link
            if ($userOwnsFile == false && $Auth->loggedIn()) {
                $links[] = '<button type="button" class="btn btn-default" onClick="copyExternalFileIntoAccount(\'' . $file->id . '\'); return false;" title="" data-original-title="' . addslashes(UCWords(TranslateHelper::t('account_file_details_duplicate_to_account', 'Duplicate File Into Your Account'))) . '" data-placement="bottom" data-toggle="tooltip"><i class="fa fa-copy"></i></button>';
            }

            if ($generalFileType == 'image') {
                $downloadLinks = '<button type="button" class="btn btn-info" data-toggle="dropdown">' . addslashes(UCWords(TranslateHelper::t('account_file_details_download', 'Download'))) . '</button> <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown"> <i class="entypo-down"></i> </button>';
                $downloadLinks .= '<ul class="dropdown-menu dropdown-info account-dropdown-resize-menu" role="menu">';
                $downloadLinks .= '<li><a href="#" onClick="openUrl(\'' . addslashes(str_replace(array('"', '\''), '', $file->generateDirectDownloadUrl())) . '\'); return false;"><i class="entypo-right"></i>' . strtoupper($file->extension) . ' ' . TranslateHelper::t('account_file_details_original', 'Original') . '</a> </li>';

                // add resize links, skip if we don't have the file dimentions
                if (($imageWidth > 0) && ($imageHeight > 0)) {
                    if ((int) $filePreviewerObj->settings['show_download_sizes'] === 1) {
                        $downloadLinks .= '<li class="divider"></li>';
                        rsort($pluginConfig['scaledPercentages']);
                        foreach ($pluginConfig['scaledPercentages'] AS $percentage) {
                            $linkWidth = ceil(($imageWidth / 100) * $percentage);
                            $linkHeight = ceil(($imageHeight / 100) * $percentage);

                            if (($linkWidth <= $filePreviewerObj::HOLDING_CACHE_SIZE) && ($linkHeight <= $filePreviewerObj::HOLDING_CACHE_SIZE)) {
                                $downloadLinks .= '<li><a href="' . _CONFIG_SITE_PROTOCOL . '://' . FileHelper::getFileDomainAndPath($file->id, $file->serverId, true) . '/cache/plugins/filepreviewer/' . (int) $file->id . '/' . $file->getFileHash() . '/' . $linkWidth . 'x' . $linkHeight . '_cropped.jpg" download><i class="entypo-right"></i>JPG ' . $linkWidth . ' x ' . $linkHeight . ' px</a> </li>';
                            }
                        }
                    }
                }
                $downloadLinks .= '</ul>';
            }
            else {
                $downloadLinks = '<button type="button" class="btn btn-info" onClick="openUrl(\'' . addslashes(str_replace(array('"', '\''), '', $file->generateDirectDownloadUrl())) . '\'); return false;">' . addslashes(UCWords(TranslateHelper::t('account_file_details_download', 'Download'))) . ' <i class="entypo-down"></i></button>';
            }

            $links[] = $downloadLinks;
        }

        // setup folder icon
        $folderCoverLink = SITE_THEME_PATH . '/images/file_icons/160px/' . $file->extension . '.png';
        if ($owner !== null) {
            if ($coverId !== null) {
                // get the cover image
                $folderCoverFile = File::loadOneById($coverId);
                $folderCoverLink = FileHelper::getIconPreviewImageUrl((array) $folderCoverFile, false, 160, false, 280, 280, 'middle');
            }
            else {
                // use account owners avatar
                $folderCoverLink = $owner->getAvatarUrl();
            }
        }

        // setup the previewer content
        $previewerHtmlContent = $this->_getPreviewerHtmlContent($file, $generalFileType, array(
            'userOwnsFile' => $userOwnsFile,
            'folder' => $folder,
            'showDownloadLink' => $showDownloadLink,
            'prev' => $prev,
            'next' => $next,
        ));

        // get info from plugins
        $filePreviewPluginPageNotice = PluginHelper::callHookRecursive('filePreviewPageNotice', array(
                    'file' => $file,
        ));
        ksort($filePreviewPluginPageNotice);

        // call any other plugin action
        PluginHelper::callHook('postFilePreview', array(
            'file' => $file,
            'userOwnsFile' => $userOwnsFile,
        ));

        // get rendered template html
        $html = $this->getRenderedTemplate('account/ajax/file_details.html', array(
            'file' => $file,
            'prev' => $prev,
            'next' => $next,
            'isPublic' => $isPublic,
            'owner' => $owner,
            'folderCoverLink' => $folderCoverLink,
            'userOwnsFile' => $userOwnsFile,
            'links' => $links,
            'folder' => $folder,
            'pluginSettings' => $pluginSettings,
            'shareAccessLevelLabel' => TranslateHelper::t('share_access_level_' . $shareAccessLevel, str_replace('_', ' & ', $shareAccessLevel)),
            'imageRawDataArr' => $imageRawDataArr,
            'showDownloadLink' => $showDownloadLink,
            'previewerHtmlContent' => $previewerHtmlContent,
            'filePreviewPluginPageNotice' => $filePreviewPluginPageNotice,
            'filePreviewPlugin' => $filePreviewerObj,
            'generalFileType' => $generalFileType,
        ));

        // prepare result
        $returnJson = array();
        $returnJson['success'] = true;
        $returnJson['html'] = $html;
        $returnJson['page_title'] = $file->originalFilename;
        $returnJson['page_url'] = $file->getFullShortUrl();
        $returnJson['javascript'] = $javascript;

        // output response
        return $this->renderJson($returnJson);
    }

    public function ajaxTrashFiles() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get database
        $db = Database::getDatabase();

        // get the current logged in user
        $Auth = AuthHelper::getAuth();

        // pickup request for later
        $request = $this->getRequest();

        // prepare result
        $result = array();
        $result['error'] = false;
        $result['msg'] = '';

        // pick up file and folder ids
        $fileIds = $request->request->get('fileIds');
        $fileIds = explode(',', $fileIds);
        $safeFileIds = array_map('intval', $fileIds);

        $folderIds = $request->request->get('folderIds');
        $folderIds = explode(',', $folderIds);
        $safeFolderIds = array_map('intval', $folderIds);

        if (CoreHelper::inDemoMode() == true) {
            $result['error'] = true;
            $result['msg'] = TranslateHelper::t("no_changes_in_demo_mode");
        }
        elseif (CoreHelper::getUsersAccountLockStatus($Auth->id) == 1) {
            $result['error'] = true;
            $result['msg'] = TranslateHelper::t('account_locked_error_message', 'This account has been locked, please unlock the account to regain full functionality.');
        }
        else {
            // track total items removed
            $totalRemoved = 0;

            // track the affected folders so we can fix stats later
            $affectedFolderIds = array();

            // do folder trashing
            if (is_array($folderIds) && count($folderIds)) {
                // load in one go for performance reasons
                $folderRows = $db->getRows('SELECT * '
                        . 'FROM file_folder '
                        . 'WHERE id IN (' . implode(',', $safeFolderIds) . ') '
                        . 'AND userId = :userId '
                        . 'AND status = "active"', array(
                    'userId' => $Auth->id,
                ));

                foreach ($folderRows AS $folderRow) {
                    // load folder and process if active and belongs to the currently logged in user
                    $folder = FileFolder::hydrateSingleRecord($folderRow);

                    // log folder id for later
                    if ((int) $folder->parentId) {
                        $affectedFolderIds[$folder->parentId] = $folder->parentId;
                    }

                    // remove file
                    $rs = $folder->trashByUser();
                    if ($rs) {
                        $totalRemoved++;
                    }
                }
            }

            // do file trashing
            if (is_array($fileIds) && count($fileIds)) {
                // load in one go for performance reasons
                $fileRows = $db->getRows('SELECT * '
                        . 'FROM file '
                        . 'WHERE id IN (' . implode(',', $safeFileIds) . ') '
                        . 'AND (userId = :userId OR uploadedUserId = :uploadedUserId)', array(
                    'userId' => $Auth->id,
                    'uploadedUserId' => $Auth->id,
                ));

                foreach ($fileRows AS $fileRow) {
                    // load file and process if active and belongs to the currently logged in user
                    $file = File::hydrateSingleRecord($fileRow);

                    // log folder id for later
                    if ((int) $file->folderId) {
                        $affectedFolderIds[$file->folderId] = $file->folderId;
                    }

                    // remove file
                    $rs = $file->trashByUser();
                    if ($rs) {
                        $totalRemoved++;
                    }
                }
            }

            // handle folder sizes regeneration
            if (count($affectedFolderIds)) {
                foreach ($affectedFolderIds AS $affectedFolderId) {
                    FileFolderHelper::updateFolderFilesize((int) $affectedFolderId);
                }
            }

            $result['msg'] = 'Removed ' . $totalRemoved . ' file' . ($totalRemoved != 1 ? 's' : '') . '.';
        }

        // output response
        return $this->renderJson($result);
    }

    public function ajaxDeleteFiles() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();

        // pickup request for later
        $request = $this->getRequest();

        // prepare result
        $result = array();
        $result['error'] = false;
        $result['msg'] = '';

        // load items
        $fileIds = $request->request->get('fileIds');
        $fileIds = explode(',', $fileIds);
        $safeFileIds = array_map('intval', $fileIds);

        $folderIds = $request->request->get('folderIds');
        $folderIds = explode(',', $folderIds);
        $safeFolderIds = array_map('intval', $folderIds);

        if (CoreHelper::inDemoMode() == true) {
            $result['error'] = true;
            $result['msg'] = TranslateHelper::t("no_changes_in_demo_mode");
        }
        elseif (CoreHelper::getUsersAccountLockStatus($Auth->id) == 1) {
            $result['error'] = true;
            $result['msg'] = TranslateHelper::t('account_locked_error_message', 'This account has been locked, please unlock the account to regain full functionality.');
        }
        else {
            $totalRemoved = 0;

            // track the affected folders so we can fix stats later
            $affectedFolderIds = array();

            // do folder removals
            if (count($safeFolderIds)) {
                foreach ($safeFolderIds AS $folderId) {
                    // load folder and process if active and belongs to the currently logged in user
                    $folder = FileFolder::loadOneById($folderId);
                    if (($folder) && ($folder->status == 'trash') && ($folder->userId == $Auth->id)) {
                        // log folder id for later
                        if ((int) $folder->parentId) {
                            $affectedFolderIds[$folder->parentId] = $folder->parentId;
                        }

                        // remove file
                        $rs = $folder->removeByUser();
                        if ($rs) {
                            $totalRemoved++;
                        }
                    }
                }
            }

            // do file removals
            if (count($safeFileIds)) {
                foreach ($safeFileIds AS $fileId) {
                    // load file and process if active and belongs to the currently logged in user
                    $file = File::loadOneById($fileId);
                    if (($file) && ($file->status == 'trash') && ($file->userId == $Auth->id || $file->uploadedUserId == $Auth->id)) {
                        // log folder id for later
                        if ((int) $file->folderId) {
                            $affectedFolderIds[$file->folderId] = $file->folderId;
                        }

                        // remove file
                        $rs = $file->removeByUser();
                        if ($rs) {
                            $totalRemoved++;
                        }
                    }
                }
            }

            // handle folder sizes regeneration
            if (count($affectedFolderIds)) {
                foreach ($affectedFolderIds AS $affectedFolderId) {
                    FileFolderHelper::updateFolderFilesize((int) $affectedFolderId);
                }
            }

            $result['msg'] = 'Permanently deleted ' . $totalRemoved . ' file' . ($totalRemoved != 1 ? 's' : '') . '.';
        }

        // output response
        return $this->renderJson($result);
    }

    public function ajaxRestoreFromTrash() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();
        $db = Database::getDatabase();

        // pickup request for later
        $request = $this->getRequest();

        // load items
        $fileIds = $request->request->get('fileIds');
        $fileIds = explode(',', $fileIds);
        $safeFileIds = array_map('intval', $fileIds);

        $folderIds = $request->request->get('folderIds');
        $folderIds = explode(',', $folderIds);
        $safeFolderIds = array_map('intval', $folderIds);

        // validation
        $checkedFileIds = array();
        if (count($safeFileIds)) {
            $checkedFileIds = $db->getRows('SELECT id '
                    . 'FROM file '
                    . 'WHERE id IN (' . implode(',', $safeFileIds) . ') '
                    . 'AND (userId = :userId OR uploadedUserId = :uploadedUserId)', array(
                'userId' => $Auth->id,
                'uploadedUserId' => $Auth->id,
            ));
        }

        $checkedFolderIds = array();
        if (count($safeFolderIds)) {
            $checkedFolderIds = $db->getRows('SELECT id '
                    . 'FROM file_folder '
                    . 'WHERE id IN (' . implode(',', $safeFolderIds) . ') '
                    . 'AND userId = :userId', array(
                'userId' => $Auth->id,
            ));
        }

        $totalItems = (int) (count($checkedFileIds) + count($checkedFolderIds));

        // load folder structure as array
        $folderListing = FileFolderHelper::loadAllActiveForSelect($Auth->id);

        // load template
        return $this->render('account/ajax/restore_from_trash.html', array(
                    'safeFileIds' => $safeFileIds,
                    'safeFolderIds' => $safeFolderIds,
                    'totalItems' => $totalItems,
                    'folderListing' => $folderListing,
        ));
    }

    public function ajaxRestoreFromTrashProcess() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();
        $db = Database::getDatabase();

        // pickup request for later
        $request = $this->getRequest();

        // handle submission
        if ($request->request->has('submitme')) {
            // make sure the user owns the folder to restore to
            $restoreFolderId = (int) $request->request->get('restoreFolderId');

            // load existing folder data
            if ($restoreFolderId > 0) {
                $fileFolder = FileFolder::loadOneById((int) $restoreFolderId);
                if ($fileFolder->userId !== $Auth->id) {
                    // revert to root as the current user does not own this folder
                    $restoreFolderId = 0;
                }
            }

            // if $restoreFolderId = 0, assume root, which is null
            $restoreFolderId = (int) $restoreFolderId === 0 ? null : (int) $restoreFolderId;

            // load items
            $fileIds = $request->request->get('fileIds');
            $fileIds = explode(',', $fileIds);
            $safeFileIds = array_map('intval', $fileIds);

            $folderIds = $request->request->get('folderIds');
            $folderIds = explode(',', $folderIds);
            $safeFolderIds = array_map('intval', $folderIds);

            // load our items for later
            $checkedFiles = array();
            if (count($safeFileIds)) {
                $checkedFiles = $db->getRows('SELECT * '
                        . 'FROM file '
                        . 'WHERE id IN (' . implode(',', $safeFileIds) . ') '
                        . 'AND (userId = :userId OR uploadedUserId = :uploadedUserId)', array(
                    'userId' => $Auth->id,
                    'uploadedUserId' => $Auth->id,
                ));
            }

            $checkedFolders = array();
            if (count($safeFolderIds)) {
                $checkedFolders = $db->getRows('SELECT * '
                        . 'FROM file_folder '
                        . 'WHERE id IN (' . implode(',', $safeFolderIds) . ') '
                        . 'AND userId = :userId', array(
                    'userId' => $Auth->id,
                ));
            }

            // restore folders
            if (COUNT($checkedFolders)) {
                foreach ($checkedFolders AS $checkedFolder) {
                    // hydrate to get access to the object methods
                    $folder = FileFolder::hydrateSingleRecord($checkedFolder);

                    // restore the file
                    $folder->restoreFromTrash($restoreFolderId);
                }
            }

            // restore files
            if (COUNT($checkedFiles)) {
                foreach ($checkedFiles AS $checkedFile) {
                    // hydrate to get access to the object methods
                    $file = File::hydrateSingleRecord($checkedFile);

                    // restore the file
                    $file->restoreFromTrash($restoreFolderId);
                }
            }
        }

        // prepare result
        $returnJson = array();
        $returnJson['success'] = false;
        $returnJson['msg'] = TranslateHelper::t("problem_restoring_items", "There was a problem restoring the items, please try again later.");
        if (NotificationHelper::isErrors()) {
            // error
            $returnJson['success'] = false;
            $returnJson['msg'] = implode('<br/>', NotificationHelper::getErrors());
        }
        else {
            // success
            $returnJson['success'] = true;
            $returnJson['msg'] = implode('<br/>', NotificationHelper::getSuccess());
        }

        // output response
        return $this->renderJson($returnJson);
    }

    public function ajaxEmptyTrash() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();

        // prepare result
        $returnJson = array();
        $returnJson['error'] = false;
        $returnJson['msg'] = '';

        if (CoreHelper::inDemoMode() == true) {
            $returnJson['error'] = true;
            $returnJson['msg'] = TranslateHelper::t("no_changes_in_demo_mode");
        }
        else {
            // empty the current users trash
            CoreHelper::emptyTrashByUserId($Auth->id);

            $returnJson['error'] = false;
            $returnJson['msg'] = 'Trash emptied.';
        }

        // output response
        return $this->renderJson($returnJson);
    }

    public function ajaxDragFilesIntoFolder() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();
        $db = Database::getDatabase();

        // pickup request for later
        $request = $this->getRequest();

        // prepare result
        $returnJson = array();
        $returnJson['error'] = false;
        $returnJson['msg'] = 'Files moved.';

        if (CoreHelper::inDemoMode() == true) {
            $returnJson['error'] = true;
            $returnJson['msg'] = TranslateHelper::t("no_changes_in_demo_mode");
        }
        elseif (CoreHelper::getUsersAccountLockStatus($Auth->id) == 1) {
            $result['error'] = true;
            $result['msg'] = TranslateHelper::t('account_locked_folder_edit_error_message', 'This account has been locked, please unlock the account to regain full functionality.');
        }
        else {
            $folderId = NULL;

            // try to load the folder
            $newStatus = 'active';
            $fileFolder = FileFolder::loadOneById($request->query->get('folderId'));
            if ($fileFolder) {
                $newStatus = $fileFolder->status;
                // make sure the current logged in user is the owner
                if ($fileFolder->userId === $Auth->id) {
                    $folderId = (int) $fileFolder->id;
                }
                // if not, check to see if the current user has access rights
                else {
                    $hasAccess = $db->getValue('SELECT id '
                            . 'FROM file_folder_share '
                            . 'LEFT JOIN file_folder_share_item ON file_folder_share.id = file_folder_share_item.file_folder_share_id '
                            . 'WHERE folder_id = :folder_id '
                            . 'AND shared_with_user_id = :shared_with_user_id '
                            . 'AND share_permission_level IN ("all", "upload_download") '
                            . 'LIMIT 1', array(
                        'folder_id' => $fileFolder->id,
                        'shared_with_user_id' => $Auth->id,
                    ));
                    if ($hasAccess) {
                        // user has write access
                        $folderId = (int) $fileFolder->id;
                    }
                }
            }

            // update files
            $fileIds = $request->query->get('fileIds');
            if (count($fileIds)) {
                // make the fileIds safe
                $safeFileIds = array_map('intval', $fileIds);

                // load all original filenames to check for duplicates
                $oldFolderId = null;
                $files = $db->getRows('SELECT originalFilename, folderId '
                        . 'FROM file '
                        . 'WHERE id IN (' . implode(',', $safeFileIds) . ') '
                        . 'AND (userId = ' . (int) $Auth->id . ' OR file.uploadedUserId = ' . (int) $Auth->id . ')');
                $originalFilenames = array();
                foreach ($files AS $file) {
                    $originalFilenames[] = $db->quote($file['originalFilename']);
                    $oldFolderId = $file['folderId'];
                }

                // make sure files don't exist already in folder
                $total = (int) $db->getValue('SELECT COUNT(id) AS total '
                                . 'FROM file '
                                . 'WHERE originalFilename IN (' . implode(',', $originalFilenames) . ') '
                                . 'AND status = "' . $newStatus . '" '
                                . 'AND folderId ' . ($folderId == NULL ? '= NULL' : '= ' . (int) $folderId) . ' '
                                . 'AND (userId = ' . (int) $Auth->id . ' OR file.uploadedUserId = ' . (int) $Auth->id . ')');
                if ($total > 0) {
                    $result['error'] = true;
                    $result['msg'] = TranslateHelper::t("items_with_same_name_in_folder", "There are already [[[TOTAL_SAME]]] file(s) with the same filename in that folder. Files can not be moved.", array('TOTAL_SAME' => $total));
                }
                else {
                    $db->query('UPDATE file '
                            . 'SET folderId ' . ($folderId == NULL ? '= NULL' : '= ' . (int) $folderId) . ', '
                            . 'status="' . $newStatus . '", '
                            . 'date_updated=NOW() '
                            . 'WHERE id IN (' . implode(',', $safeFileIds) . ') '
                            . 'AND (userId = ' . (int) $Auth->id . ' OR file.uploadedUserId = ' . (int) $Auth->id . ')');

                    // clear file preview cache
                    if (count($safeFileIds)) {
                        $pluginObj = PluginHelper::getInstance('filepreviewer');
                        if ($pluginObj) {
                            foreach ($safeFileIds AS $fileId) {
                                $pluginObj->deleteImagePreviewCache((int) $fileId);
                            }
                        }
                    }

                    // update the old folder total
                    if ($oldFolderId !== null) {
                        FileFolderHelper::updateFolderFilesize((int) $oldFolderId);
                    }

                    // update the new folder total
                    FileFolderHelper::updateFolderFilesize((int) $fileFolder->id);
                }
            }

            // update folders
            $folderIds = $request->query->get('folderIds');
            if (count($folderIds)) {
                // make the folderIds safe
                $safeFolderIds = array_map('intval', $folderIds);

                // make sure $fileFolder does not existing in list of folders
                if (($key = array_search($folderId, $safeFolderIds)) !== false) {
                    unset($safeFolderIds[$key]);
                }

                // check again that we have folders
                if (count($safeFolderIds)) {
                    // load all original filenames to check for duplicates
                    $oldFolderId = null;
                    $folders = FileFolder::loadByClause('id IN (' . implode(',', $safeFolderIds) . ') '
                                    . 'AND (userId = :userId)', array(
                                'userId' => $Auth->id,
                    ));
                    $folderNames = array();
                    foreach ($folders AS $folder) {
                        $folderNames[] = $db->quote($folder->folderName);
                        $oldFolderId = (int) $folder->parentId != 0 ? $folder->parentId : null;
                    }

                    // make sure files don't exist already in folder
                    $total = (int) $db->getValue('SELECT COUNT(id) AS total '
                                    . 'FROM file_folder '
                                    . 'WHERE folderName IN (' . implode(',', $folderNames) . ') '
                                    . 'AND status = "' . $newStatus . '" '
                                    . 'AND parentId ' . ($folderId == NULL ? '= NULL' : '= ' . (int) $folderId) . ' '
                                    . 'AND (userId = ' . (int) $Auth->id . ')');
                    if ($total > 0) {
                        $result['error'] = true;
                        $result['msg'] = TranslateHelper::t("folders_with_same_name_in_folder", "There are already [[[TOTAL_SAME]]] folders(s) with the same name in that folder. Folders can not be moved.", array('TOTAL_SAME' => $total));
                    }
                    else {
                        // restore if the folder is in the trash
                        foreach ($folders AS $folder) {
                            // if this is a trash item, restore it
                            if ($folder->status === 'trash') {
                                $folder->restoreFromTrash($folderId);
                            }
                            else {
                                // move to new folder
                                $folder->parentId = $folderId;
                                $folder->status = $newStatus;
                                $folder->date_updated = CoreHelper::sqlDateTime();
                                $folder->save();
                            }
                        }

                        // update the old folder total
                        if ($oldFolderId !== null) {
                            FileFolderHelper::updateFolderFilesize((int) $oldFolderId);
                        }

                        // update the new folder total
                        if ($folderId !== null) {
                            FileFolderHelper::updateFolderFilesize((int) $fileFolder->id);
                        }
                    }
                }
            }
        }

        // output response
        return $this->renderJson($returnJson);
    }

    public function ajaxFileDetailsSendEmailProcess() {
        // setup params for later
        $Auth = AuthHelper::getAuth();
        $request = $this->getRequest();

        // validation
        $fileId = (int) $request->request->get('fileId');
        $shareRecipientName = substr(trim($request->request->get('shareRecipientName')), 0, 255);
        $shareEmailAddress = substr(strtolower(trim($request->request->get('shareEmailAddress'))), 0, 255);
        $shareExtraMessage = trim($request->request->get('shareExtraMessage'));
        if (strlen($shareRecipientName) == 0) {
            NotificationHelper::setError(TranslateHelper::t("please_enter_the_recipient_name", "Please enter the recipient name."));
        }
        elseif (strlen($shareEmailAddress) == 0) {
            NotificationHelper::setError(TranslateHelper::t("please_enter_the_recipient_email_address", "Please enter the recipient email address."));
        }
        elseif (ValidationHelper::validEmail($shareEmailAddress) == false) {
            NotificationHelper::setError(TranslateHelper::t("please_enter_a_valid_recipient_email_address", "Please enter a valid recipient email address."));
        }
        else {
            // make sure this user owns the file
            // @TODO - or file is public if publicly sharing
            $file = File::loadOneById($fileId);
            if (!$file) {
                NotificationHelper::setError(TranslateHelper::t("could_not_load_file", "There was a problem loading the file."));
            }
            //elseif ($file->userId != Auth.id)
            //{
            //    notification.setError(t("could_not_load_file", "There was a problem loading the file."));
            //}
        }

        // send the email
        if (!NotificationHelper::isErrors()) {
            // prepare variables
            $shareRecipientName = strip_tags($shareRecipientName);
            $shareEmailAddress = strip_tags($shareEmailAddress);
            $shareExtraMessage = strip_tags($shareExtraMessage);
            $shareExtraMessage = substr($shareExtraMessage, 0, 2000);

            // blank out extra message for non logged in user
            if ($Auth->loggedIn() === false) {
                $shareExtraMessage = '';
            }

            // setup shared by names
            $sharedBy = TranslateHelper::t('guest', 'Guest');
            $sharedByEmail = '';
            if ($Auth->loggedIn() === true) {
                $sharedBy = $Auth->getAccountScreenName();
                $sharedByEmail = $Auth->email;
            }

            // send the email
            $subject = TranslateHelper::t('account_file_details_share_via_email_subject', 'File shared by [[[SHARED_BY_NAME]]] on [[[SITE_NAME]]]', array('SITE_NAME' => SITE_CONFIG_SITE_NAME, 'SHARED_BY_NAME' => $sharedBy));

            $replacements = array(
                'SITE_NAME' => SITE_CONFIG_SITE_NAME,
                'WEB_ROOT' => ThemeHelper::getLoadedInstance()->getAccountWebRoot(),
                'RECIPIENT_NAME' => $shareRecipientName,
                'SHARED_BY_NAME' => $sharedBy,
                'SHARED_EMAIL_ADDRESS' => $sharedByEmail,
                'EXTRA_MESSAGE' => strlen($shareExtraMessage) ? nl2br($shareExtraMessage) : TranslateHelper::t('not_applicable_short', 'n/a'),
                'FILE_NAME' => $file->originalFilename,
                'FILE_URL' => $file->getFullShortUrl()
            );
            $defaultContent = "Dear [[[RECIPIENT_NAME]]],<br/><br/>";
            $defaultContent .= "[[[SHARED_BY_NAME]]] has shared the following file with you via <a href='[[[WEB_ROOT]]]'>[[[SITE_NAME]]]</a>:<br/><br/>";
            $defaultContent .= "<strong>File:</strong> [[[FILE_NAME]]]<br/>";
            $defaultContent .= "<strong>View:</strong> [[[FILE_URL]]]<br/>";
            $defaultContent .= "<strong>From:</strong> [[[SHARED_BY_NAME]]] [[[SHARED_EMAIL_ADDRESS]]]<br/>";
            $defaultContent .= "<strong>Message:</strong><br/>[[[EXTRA_MESSAGE]]]<br/><br/>";
            $defaultContent .= "Feel free to contact us if you have any difficulties accessing the file.<br/><br/>";
            $defaultContent .= "Regards,<br/>";
            $defaultContent .= "[[[SITE_NAME]]] Admin";
            $htmlMsg = TranslateHelper::t('account_file_details_share_via_email_content', $defaultContent, $replacements);

            CoreHelper::sendHtmlEmail($shareEmailAddress, $subject, $htmlMsg, SITE_CONFIG_DEFAULT_EMAIL_ADDRESS_FROM, strip_tags(str_replace("<br/>", "\n", $htmlMsg)));
            NotificationHelper::setSuccess(TranslateHelper::t("file_sent_via_email_to_x", "File sent via email to [[[RECIPIENT_EMAIL_ADDRESS]]]", array('RECIPIENT_EMAIL_ADDRESS' => $shareEmailAddress)));
        }

        // prepare result
        $returnJson = array();
        $returnJson['success'] = false;
        $returnJson['msg'] = TranslateHelper::t("problem_updating_item", "There was a problem sending the email, please try again later.");
        if (NotificationHelper::isErrors()) {
            // error
            $returnJson['success'] = false;
            $returnJson['msg'] = implode('<br/>', NotificationHelper::getErrors());
        }
        else {
            // success
            $returnJson['success'] = true;
            $returnJson['msg'] = implode('<br/>', NotificationHelper::getSuccess());
        }

        return $this->renderJson($returnJson);
    }

    public function ajaxFileDetailsSimilarFiles() {
        // setup params for later
        $Auth = AuthHelper::getAuth();
        $request = $this->getRequest();

        // load file
        if ($request->query->has('u')) {
            $file = File::loadOneById($request->query->get('u'));
            if (!$file) {
                // failed lookup of file
                return $this->redirect(ThemeHelper::getLoadedInstance()->getAccountWebRoot());
            }
        }
        else {
            return $this->redirect(ThemeHelper::getLoadedInstance()->getAccountWebRoot());
        }

        $html = '';
        $similarFiles = ThemeHelper::getLoadedInstance()->getSimilarFiles($file);
        $totalFiles = count($similarFiles);
        if ($totalFiles) {
            // find index of currently selected
            $selectedIndex = 0;
            if ($totalFiles > 11) {
                foreach ($similarFiles AS $k => $totalFile) {
                    if ($totalFile->id == $file->id) {
                        $selectedIndex = $k;
                    }
                }
            }

            $html .= '<div class="similar-images-list" data-slick=\'{"initialSlide": ' . $selectedIndex . '}\'>';
            foreach ($similarFiles AS $totalFile) {
                $imageLink = FileHelper::getIconPreviewImageUrl((array) $totalFile, false, 48, false, 160, 134, 'middle');
                $html .= '<div><div class="thumbIcon"><a href="#" onClick="showFile(' . (int) $totalFile->id . '); return false;"><img data-lazy="' . $imageLink . '"/></a></div><span class="filename">' . ValidationHelper::safeOutputToScreen($totalFile->originalFilename) . '</span></div>';
            }
            $html .= '</div>';
        }

        // prepare result
        $returnJson = array();
        $returnJson['success'] = true;
        $returnJson['html'] = $html;

        return $this->renderJson($returnJson);
    }

    /**
     * Download all files as zip - generates the zip file.
     * 
     * Note: This function doesn't use the normal $response / twig template method
     * that other functions use. At some stage this will be rewritten to use Twig.
     * 
     * @param integer $folderId
     */
    public function ajaxDownloadAllAsZip($folderId) {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get params for later
        $Auth = $this->getAuth();

        // allow some time to run
        set_time_limit(60 * 60 * 4);

        // set max allowed total filesize, 4GB
        define('MAX_PERMITTED_ZIP_FILE_BYTES', 1024 * 1024 * 1024 * 4);

        // allow 1.2GB of memory to run
        ini_set('memory_limit', '1200M');

        // output styles - @TODO - replace with Twig
        echo "<style>
        body {
            font-family: helvetica neue,Helvetica,noto sans,sans-serif,Arial,sans-serif;
            font-size: 12px;
            line-height: 1.42857143;
            color: #949494;
            background-color: #fff;
        }
        a {
            text-decoration: none;
        }
        .btn {
            display: inline-block;
            margin-bottom: 0;
            font-weight: 400;
            text-align: center;
            vertical-align: middle;
            cursor: pointer;
            background-image: none;
            border: 1px solid transparent;
            white-space: nowrap;
            padding: 6px 12px;
            font-size: 12px;
            line-height: 1.42857143;
            border-radius: 3px;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            -o-user-select: none;
            user-select: none;
        }
        .btn-info {
            color: #fff;
            background-color: #21a9e1;
            border-color: #21a9e1;
        }
        </style>";

        // check for zip class
        if (!class_exists('ZipArchive')) {
            echo TranslateHelper::t('account_home_ziparchive_class_not_exists', 'Error: The ZipArchive class was not found within PHP. Please enable it within php.ini and try again.');
            exit;
        }

        // setup database
        $db = Database::getDatabase();

        // block root folder
        if ($folderId == '-1') {
            echo TranslateHelper::t('account_home_can_not_download_root', 'Error: Can not download root folder as zip file, please select a sub folder.');
            exit;
        }

        // make sure user owns folder or has permissions to download from it
        $folderData = $db->getRow('SELECT * FROM file_folder '
                . 'WHERE id = :folder_id '
                . 'AND (userId = :user_id OR id IN ('
                . 'SELECT folder_id '
                . 'FROM file_folder_share '
                . 'LEFT JOIN file_folder_share_item ON file_folder_share.id = file_folder_share_item.file_folder_share_id '
                . 'WHERE folder_id = :folder_id AND shared_with_user_id = :user_id AND share_permission_level IN ("all", "upload_download"))'
                . ') LIMIT 1', array(
            'folder_id' => $folderId,
            'user_id' => $Auth->id,
        ));
        if (!$folderData) {
            echo TranslateHelper::t('account_home_can_not_locate_folder', 'Error: Can not locate folder.');
            exit;
        }

        // build folder and file tree
        $fileData = ZipFile::getFolderStructureAsArray($folderId, $folderId, $Auth->id);
        $totalFileCount = ZipFile::getTotalFileCount($fileData[$folderData['folderName']]);
        $totalFilesize = ZipFile::getTotalFileSize($fileData[$folderData['folderName']]);
        $zipFilename = CoreHelper::generateRandomHash();

        // error if no files
        if ($totalFileCount == 0) {
            echo TranslateHelper::t('account_home_no_active_files_in_folder', 'Error: No active files in folder.');
            exit;
        }

        // check total filesize
        if ($totalFilesize > MAX_PERMITTED_ZIP_FILE_BYTES) {
            echo TranslateHelper::t('account_home_too_many_files_size', 'Error: Selected files are greater than [[[MAX_FILESIZE]]] (total [[[TOTAL_SIZE_FORMATTED]]]). Can not create zip.', array('MAX_FILESIZE' => CoreHelper::formatSize(MAX_PERMITTED_ZIP_FILE_BYTES), 'TOTAL_SIZE_FORMATTED' => CoreHelper::formatSize($totalFilesize)));
            exit;
        }

        // setup output buffering
        ZipFile::outputInitialBuffer();

        // create blank zip file
        $zip = new ZipFile($zipFilename);

        // remove any old zip files
        ZipFile::purgeOldZipFiles();

        // output progress
        ZipFile::outputBufferToScreen('Found ' . $totalFileCount . ' file' . ($totalFileCount != 1 ? 's' : '') . '.');

        // loop all files and download locally
        foreach ($fileData AS $fileDataItem) {
            // add files
            $zip->addFilesTopZip($fileDataItem);

            // do folders
            if (count($fileDataItem['folders'])) {
                $zip->addFileAndFolders($fileDataItem['folders']);
            }
        }

        // output progress
        ZipFile::outputBufferToScreen('Saving zip file...', null, ' ');

        // close zip
        $zip->close();

        // get path for later
        $fullZipPathAndFilename = $zip->fullZipPathAndFilename;

        // output progress
        ZipFile::outputBufferToScreen('Done!', 'green');
        echo '<br/>';

        // output link to zip file
        $downloadZipName = $folderData['folderName'];
        $downloadZipName = str_replace(' ', '_', $downloadZipName);
        $downloadZipName = ValidationHelper::removeInvalidCharacters($downloadZipName, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-0');

        echo '<a class="btn btn-info" href="' . ACCOUNT_WEB_ROOT . '/ajax/download_all_as_zip_get_file/' . str_replace('.zip', '', $zipFilename) . '/' . urlencode($downloadZipName) . '" target="_parent">' . TranslateHelper::t('account_home_download_zip_file', 'Download Zip File') . '&nbsp;&nbsp;(' . CoreHelper::formatSize(filesize($fullZipPathAndFilename)) . ')</a>';
        ZipFile::scrollIframe();

        echo '<br/><br/>';
        ZipFile::scrollIframe();
        exit;
    }

    public function ajaxDownloadAllAsZipGetFile($fileName, $downloadZipName) {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // allow some time to run
        set_time_limit(60 * 60 * 4);

        if (strlen($fileName) == 0) {
            return $this->render404();
        }

        // make safe
        $fileName = str_replace(array('.', '/', '\\', ','), '', $fileName);
        $fileName = validationHelper::removeInvalidCharacters($fileName, 'abcdefghijklmnopqrstuvwxyz12345678900');
        $downloadZipName = str_replace(array('.', '/', '\\', ','), '', $downloadZipName);
        $downloadZipName = validationHelper::removeInvalidCharacters($downloadZipName, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-0');

        // check for existance
        $zipFilePath = CACHE_DIRECTORY_ROOT . '/zip/' . $fileName . '.zip';
        if (!file_exists($zipFilePath)) {
            $errorMsg = TranslateHelper::t("error_zip_file_no_longer_available", "ERROR: Zip file no longer available, please regenerate to download again.");

            return $this->redirect(CoreHelper::getCoreSitePath() . "/error?e=" . urlencode($errorMsg));
        }

        return $this->renderDownloadFileFromPath($zipFilePath, $downloadZipName . '.zip');
    }

    private function _getPreviewerHtmlContent($file, $generalFileType, $otherParams) {
        // check if method exists in this class
        $methodName = '_preview' . ucfirst($generalFileType);
        if (!method_exists($this, $methodName)) {
            $methodName = '_previewDownload';
        }

        // call method and return the generated html
        return call_user_func(
                array($this, $methodName), $file, $generalFileType, $otherParams
        );
    }

    private function _previewDownload($file, $generalFileType, $otherParams) {
        // load the default icon
        $imageIcon = FileHelper::getIconPreviewImageUrl((array) $file, false, 160, false, 280, 280, 'middle');

        // load template
        return $this->getRenderedTemplate('account/partial/_preview_download.html', array(
                    'file' => $file,
                    'folder' => $otherParams['folder'],
                    'imageIcon' => $imageIcon,
                    'showDownloadLink' => $otherParams['showDownloadLink'],
                    'userOwnsFile' => $otherParams['userOwnsFile'],
                    'filePreviewerObj' => PluginHelper::getInstance('filepreviewer'),
        ));
    }

    private function _previewDocument($file, $generalFileType, $otherParams) {
        // if file previewer disabled, just show the download icon
        if (!PluginHelper::pluginEnabled('filepreviewer')) {
            return $this->_previewDownload($file, $generalFileType, $otherParams);
        }

        // load the default icon
        $imageIcon = FileHelper::getIconPreviewImageUrl((array) $file, false, 160, false, 280, 280, 'middle');

        // load template
        return $this->getRenderedTemplate('account/partial/_preview_document.html', array(
                    'file' => $file,
                    'folder' => $otherParams['folder'],
                    'imageIcon' => $imageIcon,
                    'showDownloadLink' => $otherParams['showDownloadLink'],
                    'userOwnsFile' => $otherParams['userOwnsFile'],
                    'filePreviewerObj' => PluginHelper::getInstance('filepreviewer'),
        ));
    }

    private function _previewImage($file, $generalFileType, $otherParams) {
        // if file previewer disabled, just show the download icon
        if (!PluginHelper::pluginEnabled('filepreviewer')) {
            return $this->_previewDownload($file, $generalFileType, $otherParams);
        }

        // load database
        $db = Database::getDatabase();

        // get image
        $imageLink = FileHelper::getIconPreviewImageUrl((array) $file, false, 160, false, 1100, 800, 'cropped');
        $fullScreenWidth = 2000;
        $fullScreenHeight = 2000;

        // try to load max width/height from meta data
        $imageData = $db->getRow('SELECT width, height '
                . 'FROM plugin_filepreviewer_meta '
                . 'WHERE file_id = :file_id '
                . 'LIMIT 1', array(
            'file_id' => (int) $file->id,
        ));
        if ($imageData) {
            $ratio = (int) $imageData['width'] / (int) $imageData['height'];
            $fullScreenWidth = $fullScreenHeight = min($fullScreenWidth, max((int) $imageData['width'], (int) $imageData['height']));
            if ($ratio < 1) {
                $fullScreenWidth = $fullScreenHeight * $ratio;
            }
            else {
                $fullScreenHeight = $fullScreenWidth / $ratio;
            }
        }

        // load next image link
        $imageNextLink = '';
        if ($otherParams['next'] !== null) {
            $fileNext = File::loadOneById($otherParams['next']);
            if ($fileNext) {
                $imageNextLink = FileHelper::getIconPreviewImageUrl((array) $fileNext, false, 160, false, 1100, 800, 'cropped');
            }
        }

        // load prev image link
        $imagePrevLink = '';
        if ($otherParams['prev'] !== null) {
            $filePrev = File::loadOneById($otherParams['prev']);
            if ($filePrev) {
                $imagePrevLink = FileHelper::getIconPreviewImageUrl((array) $filePrev, false, 160, false, 1100, 800, 'cropped');
            }
        }

        // load template
        return $this->getRenderedTemplate('account/partial/_preview_image.html', array(
                    'file' => $file,
                    'folder' => $otherParams['folder'],
                    'imageLink' => $imageLink,
                    'showDownloadLink' => $otherParams['showDownloadLink'],
                    'userOwnsFile' => $otherParams['userOwnsFile'],
                    'fullScreenWidth' => $fullScreenWidth,
                    'fullScreenHeight' => $fullScreenHeight,
                    'imageNextLink' => $imageNextLink,
                    'imagePrevLink' => $imagePrevLink,
                    'filePreviewerObj' => PluginHelper::getInstance('filepreviewer'),
        ));
    }

    private function _previewVideo($file, $generalFileType, $otherParams) {
        // if file previewer disabled, just show the download icon
        if (!PluginHelper::pluginEnabled('filepreviewer')) {
            return $this->_previewDownload($file, $generalFileType, $otherParams);
        }

        // load filepreviewer plugin details
        $pluginDetails = PluginHelper::pluginSpecificConfiguration('filepreviewer');
        $pluginSettings = json_decode($pluginDetails['data']['plugin_settings'], true);
        $pluginObj = PluginHelper::getInstance('filepreviewer');

        // source video poster
        $videoPosterUrl = '';
        if (PluginHelper::pluginEnabled('mediaconverter')) {
            $videoPosterUrl = FileHelper::getIconPreviewImageUrl((array) $file, false, 160, false, 640, 320);
        }

        // PPD logs via rewards plugin
        $ackPercentage = 0;
        if (PluginHelper::pluginEnabled('rewards')) {
            $rewardsPluginDetails = PluginHelper::pluginSpecificConfiguration('rewards');
            $rewardsPluginSettings = json_decode($rewardsPluginDetails['data']['plugin_settings'], true);
            $ackPercentage = (int) $rewardsPluginSettings['ppd_media_percentage'];
        }
        $downloadUrlForMedia = $file->generateDirectDownloadUrlForMedia();

        // get subtitles
        $subtitles = $pluginObj->getSubtitles($file);

        // manually build subtitle json as the player doesn't like standard JSON (Ultimate Player)
        $subText = '';
        if (count($subtitles)) {
            $subTextArr = array();
            foreach ($subtitles AS $subtitle) {
                $subTextArr[] = "{source:'" . $subtitle['source'] . "', label:'" . $subtitle['label'] . "'}";
            }
            $subText = '[' . implode(', ', $subTextArr) . ']';
        }
        
        // prepare video adverts
        $vastUrl = AdvertisingHelper::getVASTUrlForFile($file);

        // load template
        return $this->getRenderedTemplate('account/partial/_preview_video_'.$pluginObj->getVideoPlayer().'.html', array(
                    'file' => $file,
                    'folder' => $otherParams['folder'],
                    'showDownloadLink' => $otherParams['showDownloadLink'],
                    'userOwnsFile' => $otherParams['userOwnsFile'],
                    'downloadUrlForMedia' => $downloadUrlForMedia,
                    'downloadUrlForMediaBase64' => base64_encode($downloadUrlForMedia),
                    'videoThumbnail' => $videoPosterUrl,
                    'videoAutoPlay' => (int) $pluginSettings['videos_autoplay'] === 1 ? true : false,
                    'filePreviewerObj' => $pluginObj,
                    'ackPercentage' => (int) $ackPercentage,
                    'subtitles' => $subText,
                    'vastUrl' => $vastUrl,
        ));
    }

    private function _previewAudio($file, $generalFileType, $otherParams) {
        // if file previewer disabled, just show the download icon
        if (!PluginHelper::pluginEnabled('filepreviewer')) {
            return $this->_previewDownload($file, $generalFileType, $otherParams);
        }

        // load filepreviewer plugin details
        $pluginDetails = PluginHelper::pluginSpecificConfiguration('filepreviewer');
        $pluginSettings = json_decode($pluginDetails['data']['plugin_settings'], true);
        $pluginObj = PluginHelper::getInstance('filepreviewer');

        // load template
        return $this->getRenderedTemplate('account/partial/_preview_audio_'.$pluginObj->getAudioPlayer().'.html', array(
                    'file' => $file,
                    'folder' => $otherParams['folder'],
                    'imageLink' => $imageLink,
                    'showDownloadLink' => $otherParams['showDownloadLink'],
                    'userOwnsFile' => $otherParams['userOwnsFile'],
                    'downloadUrlForMedia' => $file->generateDirectDownloadUrlForMedia(),
                    'audioThumbnail' => FileHelper::getIconPreviewImageUrl((array) $file, false, 160, false, 280, 280, 'middle'),
                    'audioAutoPlay' => (int) $pluginSettings['audio_autoplay'] === 1 ? true : false,
                    'filePreviewerObj' => PluginHelper::getInstance('filepreviewer'),
        ));
    }

    private function _previewText($file, $generalFileType, $otherParams) {
        // if file previewer disabled, just show the download icon
        if (!PluginHelper::pluginEnabled('filepreviewer')) {
            return $this->_previewDownload($file, $generalFileType, $otherParams);
        }

        // load the default icon
        $imageIcon = FileHelper::getIconPreviewImageUrl((array) $file, false, 160, false, 280, 280, 'middle');

        // load template
        return $this->getRenderedTemplate('account/partial/_preview_text.html', array(
                    'file' => $file,
                    'folder' => $otherParams['folder'],
                    'showDownloadLink' => $otherParams['showDownloadLink'],
                    'userOwnsFile' => $otherParams['userOwnsFile'],
                    'filePreviewerObj' => PluginHelper::getInstance('filepreviewer'),
                    'imageIcon' => $imageIcon,
        ));
    }

    public function ajaxDuplicateFile() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();

        // pickup request for later
        $request = $this->getRequest();

        // prepare result
        $rs = array();
        $rs['error'] = true;
        $rs['msg'] = 'Failed loading selected files, please try again later.';

        // get variables
        $fileIds = $request->request->get('fileIds');

        // loop file ids and get paths
        $filePaths = array();
        if (COUNT($fileIds)) {
            foreach ($fileIds AS $fileId) {
                // load file
                $file = File::loadOneById($fileId);

                // only allow users to duplicate their own files
                if ($file->userId != $Auth->id && $file->uploadedUserId != $Auth->id) {
                    continue;
                }

                // create a copy of the file
                $newFile = $file->accountDuplicateFile();

                // if any previews exist, copy them
                $mediaConverterScreenPath = CACHE_DIRECTORY_ROOT . '/plugins/mediaconverter/' . $file->id . '/original_thumb.jpg';
                if (file_exists($mediaConverterScreenPath)) {
                    $newPath = CACHE_DIRECTORY_ROOT . '/plugins/mediaconverter/' . $newFile->id . '/';
                    mkdir($newPath, 0777, true);
                    $newFilePath = $newPath . 'original_thumb.jpg';
                    copy($mediaConverterScreenPath, $newFilePath);
                }
            }

            $rs['error'] = false;
            $rs['msg'] = TranslateHelper::t('file_manager_files_duplicated_success_message', 'Files duplicated in current folder.');
        }

        // output response
        return $this->renderJson($rs);
    }

    public function ajaxCopyToFolder() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();
        $db = Database::getDatabase();

        // pickup request for later
        $request = $this->getRequest();

        // load items
        $fileIds = $request->request->get('fileIds');
        $fileIds = explode(',', $fileIds);
        $safeFileIds = array_map('intval', $fileIds);
        $currentFolderId = $request->request->get('currentFolderId');

        // validation
        $checkedFileIds = array();
        if (count($safeFileIds)) {
            $checkedFileIds = $db->getRows('SELECT id '
                    . 'FROM file '
                    . 'WHERE id IN (' . implode(',', $safeFileIds) . ') '
                    . 'AND (userId = :userId OR uploadedUserId = :uploadedUserId)', array(
                'userId' => $Auth->id,
                'uploadedUserId' => $Auth->id,
            ));
        }

        $totalItems = (int) count($checkedFileIds);

        // load folder structure as array
        $folderListing = FileFolderHelper::loadAllActiveForSelect($Auth->id);

        // load template
        return $this->render('account/ajax/copy_to_folder.html', array(
                    'safeFileIds' => $safeFileIds,
                    'totalItems' => $totalItems,
                    'folderListing' => $folderListing,
                    'currentFolderId' => $currentFolderId,
        ));
    }

    public function ajaxCopyToFolderProcess() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();
        $db = Database::getDatabase();

        // pickup request for later
        $request = $this->getRequest();

        // prepare result
        $rs = array();
        $rs['success'] = false;
        $rs['msg'] = 'Failed loading selected files, please try again later.';

        // get variables
        $fileIds = $request->request->get('fileIds');
        $fileIds = explode(',', $fileIds);
        $safeFileIds = array_map('intval', $fileIds);

        // pickup new folder id
        $copyFolderId = (int) $request->request->get('copyFolderId');

        // loop file ids and get paths
        $filePaths = array();
        if (count($safeFileIds)) {
            // load all file data - only allow users to duplicate their own files
            $fileRows = $db->getRows('SELECT * '
                    . 'FROM file '
                    . 'WHERE id IN (' . implode(',', $safeFileIds) . ') '
                    . 'AND (userId = :userId OR uploadedUserId = :uploadedUserId)', array(
                'userId' => $Auth->id,
                'uploadedUserId' => $Auth->id,
            ));

            if (count($fileRows)) {
                foreach ($fileRows AS $fileRow) {
                    // load file
                    $file = File::hydrateSingleRecord($fileRow);

                    // create a copy of the file
                    $newFile = $file->accountDuplicateFile($copyFolderId);

                    // if any previews exist, copy them
                    $mediaConverterScreenPath = CACHE_DIRECTORY_ROOT . '/plugins/mediaconverter/' . $file->id . '/original_thumb.jpg';
                    if (file_exists($mediaConverterScreenPath)) {
                        $newPath = CACHE_DIRECTORY_ROOT . '/plugins/mediaconverter/' . $newFile->id . '/';
                        mkdir($newPath, 0777, true);
                        $newFilePath = $newPath . 'original_thumb.jpg';
                        copy($mediaConverterScreenPath, $newFilePath);
                    }

                    $filePreviewerCachePath = CACHE_DIRECTORY_ROOT . '/plugins/filepreviewer/' . $file->id . '/' . $file->unique_hash;
                    if (is_dir($filePreviewerCachePath)) {
                        $newPath = CACHE_DIRECTORY_ROOT . '/plugins/filepreviewer/' . $newFile->id . '/' . $newFile->unique_hash;
                        CoreHelper::recurseCopy($filePreviewerCachePath, $newPath);
                    }
                }
            }

            $rs['success'] = true;
            $rs['msg'] = TranslateHelper::t('file_manager_files_duplicated_success_message', 'Files duplicated in current folder.');
        }

        // output response
        return $this->renderJson($rs);
    }

    public function ajaxAccountCopyFile() {
        // require user login
        if (($response = $this->requireLogin()) !== false) {
            return $response;
        }

        // get the current logged in user
        $Auth = AuthHelper::getAuth();
        $db = Database::getDatabase();

        // pickup request for later
        $request = $this->getRequest();
        $fileId = $request->request->get('fileId');

        // prepare result
        $rs = array();
        $rs['success'] = false;
        $rs['msg'] = TranslateHelper::t('failed_to_copy_file', 'There was a problem copying the file, please try again later.');

        // load file
        $file = File::loadOneById($fileId);
        if (!$file) {
            // failed lookup of file
            return $this->renderJson($rs);
        }

        // make sure the file is active
        if ($file->status != 'active') {
            // failed lookup of file
            return $this->renderJson($rs);
        }

        // make sure the file doesn't have a password
        if (strlen($file->accessPassword)) {
            // failed lookup of file
            return $this->renderJson($rs);
        }

        // if this user already owns the file, don't copy
        if ($file->userId == $Auth->id) {
            // failed lookup of file
            return $this->renderJson($rs);
        }

        // if the file is limited to a specific user type, check that they are permitted to copy it
        if ($file->minUserLevel != null) {
            // check that the user has the correct file level
            if ((int) $Auth->level_id < (int) $file->minUserLevel) {
                if (($file->userId != null) && ($Auth->user_id == $file->userId)) {
                    // ignore the restriction if this is the original user which uploaded the file
                }
                else {
                    $userTypeLabel = $db->getValue('SELECT label '
                            . 'FROM user_level '
                            . 'WHERE level_id = :level_id'
                            . 'LIMIT 1', array(
                        'level_id' => (int) $file->minUserLevel,
                    ));
                    $rs['msg'] = TranslateHelper::t("error_you_must_be_a_x_user_to_copy_this_file", "You must be a [[[USER_TYPE]]] to copy this file.", array('USER_TYPE' => $userTypeLabel));

                    return $this->renderJson($rs);
                }
            }
        }

        // attempt to copy the file
        $newFile = $file->duplicateFile();

        // on failure
        if (!$newFile) {
            // failed creating copy
            return $this->renderJson($rs);
        }

        // success response
        $rs['success'] = true;
        $rs['newFileId'] = $newFile->id;
        $rs['msg'] = TranslateHelper::t('file_copied', 'File copied into your account - [[[FILE_LINK]]]', array(
            'FILE_LINK' => $newFile->originalFilename,
        ));

        return $this->renderJson($rs);
    }

}
