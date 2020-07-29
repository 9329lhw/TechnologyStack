<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Auth;

class WeChateController extends Controller
{
    public function wxcode()
    {
      //一定要按照参数的顺序进行排列，否则接口将无法访问
      $params = http_build_query([
        'appid' => 'wx3fcdb70eb5f80571',
        'redirect_uri'=> 'http://lms-shops.com/wxtoken',
        'response_type' => 'code',
        'scope' => 'snsapi_userinfo'
      ]);

      $url = 'https://open.weixin.qq.com/connect/oauth2/authorize?'.$params .'#wechat_redirect';
      return redirect($url);
    }

    public function wxtoken(Request $request)
    {
      $code = $request->input('code');
      $params = http_build_query([
        'appid' => 'wx3fcdb70eb5f80571',
        'secret'=> '30f97ea22284973ec18efe628ef69562',
        'code' => $code,
        'grant_type' => 'authorization_code'
      ]);
      $url = 'https://api.weixin.qq.com/sns/oauth2/access_token?'.$params;
      $result = json_decode(file_get_contents($url));
      // dd($result);
      $params = http_build_query([
        'access_token' => $result->access_token,
        'openid' => $result->openid,
        'lang' => 'zh_CN',
      ]);
      $url = 'https://api.weixin.qq.com/sns/userinfo?'.$params;
      $UserInfo = json_decode(file_get_contents($url));
      dd($UserInfo);
    }

    public function auth(Request $request)
    {
      $WeChatUserInfo = session('wechat.oauth_user.default');

      // dd($WeChatUserInfo);
      // exit

      $UserInfo = User::where('Openid',$WeChatUserInfo['id'])->first();

      if (!$UserInfo) {
        //用户的密码需要他在第一次登录的时候进行设置
        //手机号码需要进行绑定,需要根据用户id来进行异构索引表分表
        $result = User::create([
          'id' => $this->uuid(),
          'Openid' => $WeChatUserInfo['id'],
          'username' => $WeChatUserInfo['name'],
          'role_id' => 1,//角色默认1位普通用户
          'vender_type' => 2,
          'status' => 0,
          'login_ip' => $request->getClientIp()
        ]);
      }else{
        $result = $UserInfo;
      }

      //登录验证
      Auth::login($result,true);

      $redirect_url = $request->redirect_url;
      if ($redirect_url == '') {
        // code...
        return \redirect('/products');
      }else{
        return \redirect($redirect_url);
      }
    }

    public function uuid($prefix='')
    {
      // code...
      $str = md5(uniqid(mt_rand(), true));
      $uuid  = substr($str,0,8) . '-';
      $uuid .= substr($str,8,4) . '-';
      $uuid .= substr($str,12,4) . '-';
      $uuid .= substr($str,16,4) . '-';
      $uuid .= substr($str,20,12);
      return $prefix . $uuid;
    }
}
