//开发环境
import 'env.dart';

const SERVER_HOST_DEV = 'http://localhost:8000';
//生产环境
const SERVER_HOST_PROD = '';
const ENV_IS_DEV = ENV == "DEV";
const SERVER_API_URL = ENV_IS_DEV ? SERVER_HOST_DEV : SERVER_HOST_PROD;
const PUSH_PREFIX = ENV_IS_DEV ? 'test_' :"prod_";

//七牛
const QINIU_UPLOAD_TOKEN = 'a5vhAGQErwrixYoGL6IQPDpnok1OZo17rniNKx7t:hb5lv4VuqvEHULLvdOJTM8-LJ0s=:eyJzY29wZSI6Inp6Z2VlayIsImRlYWRsaW5lIjoxNjYyMDQ1MzkzfQ==';
const QINIU_CDN_HOST = 'http://rhevpye93.hn-bkt.clouddn.com/';
