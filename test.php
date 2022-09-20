<?php

define('DRUPAL_ROOT', getcwd());
require_once DRUPAL_ROOT . '/includes/bootstrap.inc';

drupal_bootstrap(DRUPAL_BOOTSTRAP_FULL);

$url = 'https://api.github.com/repos/guzzle/guzzle';

$result = drupal_http_request($url);
