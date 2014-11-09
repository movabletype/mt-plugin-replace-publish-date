package ReplacePublishDate::CMS;

use strict;
use warnings;

sub cms_post_save_entry {
    my ( $cb, $app, $obj, $orig ) = @_;
    my $update_publish_date = $app->param('change_publish_date') || 0;
    my $update_publish_time = $app->param('change_publish_time') || 0;

    $obj->meta('change_publish_date', $update_publish_date);
    $obj->meta('change_publish_time', $update_publish_time);
    $obj->save;

    return $obj;
}

1;
