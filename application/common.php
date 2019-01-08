<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件
/**
 * 上传图片
 * @param $file 文件流
 * @param $type 文件类型，图形需要压缩
 * **/
function uploads($file, $type="img"){
    $info = $file->validate(['size'=>80678000])->move(ROOT_PATH . 'public' . DS . 'uploads');
    $pa=$info->getSaveName();
    $path=str_replace("\\", "/", $pa);
    $paths='/uploads/'.$path;
    if($type == "img"){
        $images=\think\Image::open(ROOT_PATH.'/public'.$paths);
        $images->save(ROOT_PATH.'/public'.$paths,null,60,true);
    }
    return $paths;
}

/**
* 删除图片
*/
function deleteImg($oldImg, $is_full = false){
    if($oldImg != ''){
        if($is_full == false){
            $path = ROOT_PATH . 'public' . DS .$oldImg;
        }else{
            $path = $oldImg;
        }
        if ($path != ROOT_PATH . 'public' . DS) {
            if(is_file($path) == true) {
                unlink($path);
            }
        }
    }
}

/**
 * 发送短信
 * */
function Post($phone,$code){
    $post_data = array();
    $post_data['userid'] = 5600;
    $post_data['account'] = '至开科技';
    $post_data['password'] = '123456';
    $post_data['content'] = '【微信书城】您的验证码为'.$code.'，请您在5分钟内完成操作。'; //短信内容需要用urlencode编码下
    $post_data['mobile'] = "$phone";
    $post_data['sendtime'] = ''; //不定时发送，值为0，定时发送，输入格式YYYYMMDDHHmmss的日期值

    $url='http://114.55.11.126:8888/sms.aspx?action=send';
    $o='';
    foreach ($post_data as $k=>$v)
    {
        $o.="$k=".urlencode($v).'&';
    }
    $post_data=substr($o,0,-1);
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_URL,$url);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //如果需要将结果直接返回到变量里，那加上这句。
    $result = curl_exec($ch);
}

/**
 * txt小说按章节拆分
 * @param str $file_name txt文件完整路径
 * @param str $start_str 章节名前规则
 * @param str $end_str 章节名后规则
 * @param str $regular 正则表达式
 */
function txt_split($file_name, $start_str="第", $end_str="章", $regular = '')
{
    set_time_limit(0);//0表示不限时

    $file = fopen($file_name, "r"); //文件

    $xs_capter_list = []; //标题
    $xs_content_list = []; //内容
    $i = 0;//行数
    $j = 1; //章节数
    $content = ''; //内容临时存储
    $chaptertitle =''; //标题临时存储

    //输出文本中所有的行，直到文件结束为止。
    while(true) {
        if(feof($file)){
            //文章结尾
            if($content!='' && $chaptertitle!=''){
                $content = strtr($content,["\r\n" => '<br>']);
                // $content = mb_substr($content,49);//去掉前49个广告字符
                $xs_content_list[] = $content;
                $xs_capter_list[] = $chaptertitle;
                break;
            }
            break;
        }else{
            $now = fgets($file);
            $now = mb_convert_encoding($now,'UTF-8','UTF-8,GBK,GB2312,BIG5');//使用该函数对结果进行转码
            //判断是否是章节名
            if($regular != ''){
                if(preg_match("$regular", "$now") != FALSE){
                    //判断是否已经存储着内容，如果存储着内容则说明还是本章内容，如果为空则说明进入了下一个章节
                    if($content!='' && $chaptertitle!=''){
                        //执行插入操作
                        $content = strtr($content,["\r\n" => '<br>']);
                        // $content = mb_substr($content,49);//去掉前49个广告字符
                        $xs_content_list[] = $content;
                        $xs_capter_list[] = $chaptertitle;
                        //成功后
                        $content = '';
                        $chaptertitle = strtr($now,["\r\n" => '']);
                        $j++;
                    }else{
                        $content .= $now;
                        $chaptertitle = strtr($now,["\r\n" => '']);
                    }
                }else{
                    $content .= $now;
                }
            }else{
                if(strpos($now, $start_str)!==FALSE and strpos($now, $end_str)!==FALSE){
                    //判断是否已经存储着内容，如果存储着内容则说明还是本章内容，如果为空则说明进入了下一个章节
                    if($content!='' && $chaptertitle!=''){
                        //执行插入操作
                        $content = strtr($content,["\r\n" => '<br>']);
                        // $content = mb_substr($content,49);//去掉前49个广告字符
                        $xs_content_list[] = $content;
                        $xs_capter_list[] = $chaptertitle;
                        //成功后
                        $content = '';
                        $chaptertitle = strtr($now,["\r\n" => '']);
                        $j++;
                    }else{
                        $content .= $now;
                        $chaptertitle = strtr($now,["\r\n" => '']);
                    }
                }else{
                    $content .= $now;
                }
            }
        }
        $i++;
    }
    $chapter = array();
    foreach($xs_capter_list as $key=>$v){
        $chapter[$key]['title'] = $v;
        $chapter[$key]['content'] = $xs_content_list[$key];
    }
    fclose($file);
    //导入完成，删除上传的txt文件
    deleteImg($file_name, true);
    return $chapter;
}