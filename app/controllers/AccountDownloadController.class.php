<?php

namespace App\Controllers;

use App\Models\File;
use App\Models\FileFolder;
use App\Helpers\CoreHelper;

class AccountDownloadController extends AccountController
{
    /**
     * Called from JS in the file manager. Will only allow account owner to download
     * the file.
     * 
     * @param type $fileId
     * @return type
     */
    public function directDownload($fileId) {
        // get params for later
        $Auth = $this->getAuth();

        // load the file and make sure user owns it
        $file = File::loadOneById($fileId);
        if(!$file) {
            return $this->render404();
        }
        
        // check file permissions, allow owners and admin/mods
        if ((($file->userId != $Auth->id) && ($Auth->level_id < 10))) {
            // account owner only
            return $this->render404();
        }
        
        // if we've got this far, the user can access the file
        return $this->redirect($file->generateDirectDownloadUrl());
    }
}
