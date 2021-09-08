package com.bjpowernode.crm.base.util;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class FileUploadUtil {

    public static ResultVo fileUpload(MultipartFile photo, HttpServletRequest request) {
        ResultVo resultVo = new ResultVo();
        //文件路径
        String realPath = request.getSession().getServletContext().getRealPath("/upload");
        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdirs();
        }

        //文件名不能重复
        String filename = photo.getOriginalFilename();
        filename = System.currentTimeMillis() + filename;

        try {
            //文件扩展名是否正确
            checkSuffix(filename);

            //文件的大小不能大于2M
            checkFileSize(photo.getSize());

            photo.transferTo(new File(realPath + File.separator + filename));
            String photoPath = request.getContextPath() + File.separator + "upload" + File.separator + filename;
            resultVo.setT(photoPath);
            resultVo.setResOK(true);
            resultVo.setMessage("上传文件成功");
        } catch (IOException e) {
            e.printStackTrace();
        } catch (CrmException e1) {
            resultVo.setMessage(e1.getMessage());
        }
        return resultVo;
    }

    //文件扩展名是否正确
    private static void checkSuffix(String filename) {
        //允许的后缀
        String correctSuffix = "png,webp,gif,bmp";
        //文件的后缀
        String suffix = filename.substring(filename.lastIndexOf(".") + 1);
        if (!correctSuffix.contains(suffix)) {
            throw new CrmException(CrmEnum.USER_UPDATE_FILESUFFIXFALSE);
        }
    }

    //文件的大小不能大于2M
    private static void checkFileSize(long size) {
        long maxSize = 2 * 1024 * 1024;
        if (size > maxSize) {
            throw new CrmException(CrmEnum.USER_UPDATE_FILESIZEFALSE);
        }
    }
}
