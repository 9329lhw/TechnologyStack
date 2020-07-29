<?php

namespace App\Admin\Controllers;

use App\User;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class UserController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Users';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new User());

        $grid->column('id', __('Id'));
        $grid->column('Openid', __('Openid'));
        $grid->column('username', __('Username'));
        $grid->column('password', __('Password'));
        $grid->column('role_id', __('Role id'));
        $grid->column('vender_type', __('Vender type'));
        $grid->column('status', __('Status'));
        $grid->column('mobile', __('Mobile'));
        $grid->column('login_ip', __('Login ip'));
        $grid->column('remember_token', __('Remember token'));
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));

        return $grid;
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     * @return Show
     */
    protected function detail($id)
    {
        $show = new Show(User::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('Openid', __('Openid'));
        $show->field('username', __('Username'));
        $show->field('password', __('Password'));
        $show->field('role_id', __('Role id'));
        $show->field('vender_type', __('Vender type'));
        $show->field('status', __('Status'));
        $show->field('mobile', __('Mobile'));
        $show->field('login_ip', __('Login ip'));
        $show->field('remember_token', __('Remember token'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new User());

        $form->text('Openid', __('Openid'));
        $form->text('username', __('Username'));
        $form->password('password', __('Password'));
        $form->number('role_id', __('Role id'));
        $form->switch('vender_type', __('Vender type'));
        $form->switch('status', __('Status'));
        $form->mobile('mobile', __('Mobile'));
        $form->text('login_ip', __('Login ip'));
        $form->text('remember_token', __('Remember token'));

        return $form;
    }
}
