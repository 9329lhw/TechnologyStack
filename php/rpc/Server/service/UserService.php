<?php

class UserService
{
    public function getUserInfo($uid)
    {
        // 假设以下内容从数据库取出
        return [
            'id'       => $uid,
            'username' => 'peter',
        ];
    }
}
