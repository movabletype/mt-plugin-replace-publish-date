package ReplacePublishDate::Transformer;

use strict;
use warnings;

sub template_param_edit_entry {
    my ( $cb, $app, $param, $tmpl ) = @_;
    my $plugin = MT->component('ReplacePublishDate');

    # Load?
    my $checked_date = '';
    my $checked_time = '';
    if ( my $id = $app->param('id') ) {
        if ( my $e = $app->model('entry')->load($id) ) {
            $checked_date = ( $e->meta('change_publish_date') || 0 ) ? ' checked="checked"' : '';
            $checked_time = ( $e->meta('change_publish_time') || 0 ) ? ' checked="checked"' : '';
        }
    }

    # Append options
    my $date_label = $plugin->translate('Published Date is current date');
    my $time_label = $plugin->translate('Published Time is current time');
    my $inner_html = <<HTML;
<ul>
  <li><input type="checkbox" id="change-publish-date" name="change_publish_date" class="cb checkbox" $checked_date value="1" /> <label for="change-publish-date">$date_label</label></li>
  <li><input type="checkbox" id="change-publish-time" name="change_publish_time" class="cb checkbox" $checked_time value="1" /> <label for="change-publish-time">$time_label</label></li>
</ul>
HTML

    my $placeholder = $tmpl->getElementById('authored_on');
    my $element = $tmpl->createElement(
        'app:setting',
        {
            id          => 'publish-date-change-option',
            label_class => "top-label",
        }
    ) or return $app->error('cannot create a new element.');
    $element->innerHTML($inner_html);

    $tmpl->insertAfter( $element, $placeholder )
        or return $app->error('failed to insertBefore.');

    # Support Script
    $param->{jq_js_include} ||= '';
    $param->{jq_js_include} .= <<SCRIPT;
    jQuery('#entry_form').submit(function() {
        var date = new Date();
        if ( jQuery('#change-publish-date').attr("checked") === 'checked' ) {
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            if ( month < 10 ) {
                month = '0' + month;
            }
            var day = date.getDate();
            if ( day < 10 ) {
                day = '0' + day;
            }
            jQuery('#created-on').val(year + '-' + month + '-' + day);
        }
        if ( jQuery('#change-publish-time').attr("checked") === 'checked' ) {
            var hour = date.getHours();
            if ( hour < 10 ) {
                hour = '0' + hour;
            }
            var min = date.getMinutes();
            if ( min < 10 ) {
                min = '0' + min;
            }
            var seconds = date.getSeconds();
            if ( seconds < 10 ) {
                seconds = '0' + seconds;
            }
            jQuery('[name="authored_on_time"]').val(hour + ':' + min + ':' + seconds);
        }
    });
SCRIPT

}

1;
