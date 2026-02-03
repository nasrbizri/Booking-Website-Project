<?php 
$HOME_INCLUDE_PATH = "{$_SERVER['DOCUMENT_ROOT']}/project2/";
$HOME_URL = "https://{$_SERVER['SERVER_NAME']}/project2/";
$HOME_ROUTE = "/project2/";
set_include_path($HOME_INCLUDE_PATH);
if (PHP_SESSION_NONE === session_status()) {
    session_start();
}
?>