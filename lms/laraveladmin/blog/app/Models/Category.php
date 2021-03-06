<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    //
    protected $connection = 'mysql_products';

    protected $fillable = ['name','parent_id','is_directory','level','path'];

    protected $casts = [
      'is_directory' => 'boolean',
    ];

    public static function boot()
    {
      // code...
      parent::boot();
      //监听Category的创建事件，用于初始化path和level的值
      static::creating(function (Category $category){
        //如果创建的是一个根目录
        if (is_null($category->parent_id)) {
          $category->level = 0;
          $category->path = '-';
        }else{
          $category->level = $category->parent->level+1;
          $category->path =  $category->parent->path.$category->parent_id.'-';
        }
      });

    }

    public function parent()
    {
      return $this->belongsTo(Category::class);
    }

    public function children()
    {
      return $this->hasMany(Category::class,'parent_id');
    }

    public function product()
    {
      return $this->hasMany(Product::class);
    }

    public function getPathIdsAttribute()
    {
      return array_filter(explode('-',trim($this->path,'-')));
    }

//定义一个访问器，获取所有祖先类目并且按照层级进行排序
    public function getAncestorsAttribute()
    {
      return Category::query()
              ->whereIn('id',$this->path_ids)
              ->orderBy('level')
              ->get();
    }

    // 定义一个访问器，获取以 - 为分隔的所有祖先类目名称以及当前类目的名称
    public function getFullNameAttribute()
    {
        return $this->ancestors  // 获取所有祖先类目
                    ->pluck('name') // 取出所有祖先类目的 name 字段作为一个数组
                    ->push($this->name) // 将当前类目的 name 字段值加到数组的末尾
                    ->implode(' - '); // 用 - 符号将数组的值组装成一个字符串
    }
}
