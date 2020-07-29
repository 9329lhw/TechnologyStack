<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\User;

class UserInfo extends Model
{
    protected $table = 'user_info';
    protected $fillable = [
      'user_id','age','image','birthday','email','level_id',
      'sex','identity_type','identity_no','user_description','deleted_at'
    ];
    //
    public function user($value='')
    {
      return $this->belongsTo(User::class);
    }
}
