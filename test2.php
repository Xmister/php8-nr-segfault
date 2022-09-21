<?php
// newrelic_ignore_transaction();

define('DRUPAL_ROOT', getcwd());

require_once DRUPAL_ROOT . '/includes/bootstrap.inc';
drupal_bootstrap(DRUPAL_BOOTSTRAP_FULL);
require_once DRUPAL_ROOT . '/modules/update/update.fetch.inc';

$full_url = 'http://updates.drupal.org/release-history/drupal/7.x?version=7.92&list=block%2Ccolor%2Ccomment%2Ccontextual%2Cdashboard%2Cdblog%2Cfield%2Cfield_sql_storage%2Cfield_ui%2Cfile%2Cfilter%2Chelp%2Cimage%2Clist%2Cmenu%2Cnode%2Cnumber%2Coptions%2Cpath%2Crdf%2Csearch%2Cshortcut%2Csystem%2Ctaxonomy%2Ctext%2Ctoolbar%2Cupdate%2Cuser%2Cbartik%2Cseven';

$url = str_pad('http://updates.drupal.org/', strlen($full_url), 'x');
$result = drupal_http_request($url);
$data = file_get_contents(DRUPAL_ROOT . '/test.xml');
//print $result->data;
$parsed = update_parse_xml($data);
print_r($parsed);
