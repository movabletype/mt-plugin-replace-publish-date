package ReplacePublishDate::L10N::ja;

use strict;
use utf8;
use base 'ReplacePublishDate::L10N::en_us';
use vars qw( %Lexicon );

%Lexicon = (

## plugins/ReplacePublishDate/Config.yaml
	'This plugin replaces the Published Date & Time with the current date and time automatically when you save the entry.' => 'このプラグインは、記事の保存時に公開日時を現在日時で自動で置き換えます。',

## plugins/ReplacePublishDate/lib/ReplacePublishDate/Transformer.pm
	'Published Date is current date' => '公開日を保存した日にする',
	'Published Time is current time' => '公開時間を保存した時間にする',

);

1;
