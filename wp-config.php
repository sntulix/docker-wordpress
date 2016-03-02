<?php
/**
 * WordPress の基本設定
 *
 * このファイルは、インストール時に wp-config.php 作成ウィザードが利用します。
 * ウィザードを介さずにこのファイルを "wp-config.php" という名前でコピーして
 * 直接編集して値を入力してもかまいません。
 *
 * このファイルは、以下の設定を含みます。
 *
 * * MySQL 設定
 * * 秘密鍵
 * * データベーステーブル接頭辞
 * * ABSPATH
 *
 * @link http://wpdocs.sourceforge.jp/wp-config.php_%E3%81%AE%E7%B7%A8%E9%9B%86
 *
 * @package WordPress
 */

// 注意: 
// Windows の "メモ帳" でこのファイルを編集しないでください !
// 問題なく使えるテキストエディタ
// (http://wpdocs.sourceforge.jp/Codex:%E8%AB%87%E8%A9%B1%E5%AE%A4 参照)
// を使用し、必ず UTF-8 の BOM なし (UTF-8N) で保存してください。

// ** MySQL 設定 - この情報はホスティング先から入手してください。 ** //
/** WordPress のためのデータベース名 */
define('DB_NAME', 'wordpress');

/** MySQL データベースのユーザー名 */
define('DB_USER', 'wpadmin');

/** MySQL データベースのパスワード */
define('DB_PASSWORD', 'password');

/** MySQL のホスト名 */
define('DB_HOST', 'localhost');

/** データベースのテーブルを作成する際のデータベースの文字セット */
define('DB_CHARSET', 'utf8mb4');

/** データベースの照合順序 (ほとんどの場合変更する必要はありません) */
define('DB_COLLATE', '');

/**#@+
 * 認証用ユニークキー
 *
 * それぞれを異なるユニーク (一意) な文字列に変更してください。
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org の秘密鍵サービス} で自動生成することもできます。
 * 後でいつでも変更して、既存のすべての cookie を無効にできます。これにより、すべてのユーザーを強制的に再ログインさせることになります。
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'zKMFg36H,U&l8/^ =Pz~9UcYE#|w_yt>j=X{~0SwN6CuEm+~qJV[L@0N(MVx!D.d');
define('SECURE_AUTH_KEY',  '(QGIjp3`P=~+dS}t1~9^%~vx]bc<<IO[l 4[Ke,cg)n#:p*a;71=3dl+A;a[;0-2');
define('LOGGED_IN_KEY',    'OOpFsLuvGXpO-n+<:}P03=]3NIP?5-7pF9G4L|Ev+,#~$/ NH@oPT[D<lBBh}lGt');
define('NONCE_KEY',        'EehtHra$)l?N>,^|jl6Q~Fjc![U:Lt;wcrG!(-HNnI]U9<=^`R6Bx>Hvd.{2#fpJ');
define('AUTH_SALT',        '`-4@T?S%BR woX*+U[+*HSRW+-,#mkZS&zw!;|8RJTG`8rc.VS#-B-B=BX52)<mE');
define('SECURE_AUTH_SALT', '-1)Nb={5-iVcs1,Sq,H<;67Q_W`,G_5y{>}cyYf[E5yLkYEw/EL6!@k6&Z7rlF04');
define('LOGGED_IN_SALT',   '(WUecAv8hT}_kuo2s^y}mMy*w|JXW*@|/Zf]J;++5@%m=hc_ *zN;GU.:s][yo>Q');
define('NONCE_SALT',       'Z#Uvp|2su0(f~GdB<yRT:W,b_+TIhz/+E0g.+YirUBtdy^U.3s3E4RXz0yF*c,62');

/**#@-*/

/**
 * WordPress データベーステーブルの接頭辞
 *
 * それぞれにユニーク (一意) な接頭辞を与えることで一つのデータベースに複数の WordPress を
 * インストールすることができます。半角英数字と下線のみを使用してください。
 */
$table_prefix  = 'wp_';

/**
 * 開発者へ: WordPress デバッグモード
 *
 * この値を true にすると、開発中に注意 (notice) を表示します。
 * テーマおよびプラグインの開発者には、その開発環境においてこの WP_DEBUG を使用することを強く推奨します。
 *
 * その他のデバッグに利用できる定数については Codex をご覧ください。
 *
 * @link http://wpdocs.osdn.jp/WordPress%E3%81%A7%E3%81%AE%E3%83%87%E3%83%90%E3%83%83%E3%82%B0
 */
define('WP_DEBUG', false);

/* 編集が必要なのはここまでです ! WordPress でブログをお楽しみください。 */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

