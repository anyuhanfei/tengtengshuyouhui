<?php
namespace app\admin\controller;

class About extends BaseAdmin
{
    public function index()
    {
        $re=db("about")->where("id=1")->find();
        $this->assign("re",$re);
        return \view("index");
    }
    public function save()
    {
        $re=db("about")->where("id=1")->find();
        $data=\input('post.');

        if(!\is_string(\input('image'))){
            $data['image']=\uploads("image");
        }else{
            $data['image']=$re['image'];
        }
        $res=db("about")->where("id=1")->update($data);
        if($res){
            $this->success("修改成功");
        }else{
            $this->error("修改失败");
        }
    }
    public function lister()
    {
        $re=db("about")->where("id=2")->find();
        $this->assign("re",$re);
        return \view("lister");
    }
    public function saves()
    {
        $re=db("about")->where("id=2")->find();
        $data=\input('post.');

        if(!\is_string(\input('image'))){
            $data['image']=\uploads("image");
        }else{
            $data['image']=$re['image'];
        }
        $res=db("about")->where("id=2")->update($data);
        if($res){
            $this->success("修改成功");
        }else{
            $this->error("修改失败");
        }
    }
    public function custom()
    {
        $re=db("about")->where("id=3")->find();
        $this->assign("re",$re);
        return \view("custom");
    }
    public function savec()
    {
        $re=db("about")->where("id=3")->find();
        $data=\input('post.');
        if(!\is_string(\input('image'))){
            $data['image']=\uploads("image");
        }else{
            $data['image']=$re['image'];
        }
        $res=db("about")->where("id=3")->update($data);
        if($res){
            $this->success("修改成功");
        }else{
            $this->error("修改失败");
        }
    }
    
    
    
    
}