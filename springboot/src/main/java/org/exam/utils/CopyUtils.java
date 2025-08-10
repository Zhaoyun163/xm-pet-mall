package org.exam.utils;


import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;

/**
 * 复制代码工具类
 * 作者：程序员青戈
 */
public class CopyUtils {

    private static final String BASE_PATH = System.getProperty("user.dir") + "\\springboot\\src\\main\\java\\org\\exam";   // Springboot项目根路径
    private static final String CONTROLLER_PATH = BASE_PATH + "\\controller\\";   // Springboot项目controller包根路径
    private static final String SERVICE_PATH = BASE_PATH + "\\service\\";  // Springboot项目service包根路径
    private static final String MAPPER_PATH = BASE_PATH + "\\mapper\\";  // Springboot项目mapper包根路径
    private static final String MAPPER_XML_PATH = System.getProperty("user.dir") + "\\springboot\\src\\main\\resources\\mapper\\";  // Springboot项目mapper.xml目录根路径
    private static final String VUE_PATH = System.getProperty("user.dir") + "\\vue\\src\\views\\manager\\";  // vue项目管理页面根路径

    //  ---------------下面的部分需要修改-------------------------------------------
    private static final String ORIGIN_TABLE = "pet";  // 作为参考复制的表名称
    private static final String COPY_TABLE = "order";  // 即将要复制出来的表名称
    //  --------------------------------------------------------------------------

    public static void main(String[] args) {
        String originEntityName = StrUtil.toCamelCase(ORIGIN_TABLE);
        String originClassName = StrUtil.upperFirst(originEntityName);

        String copyEntityName = StrUtil.toCamelCase(COPY_TABLE);
        String copyClassName = StrUtil.upperFirst(copyEntityName);

        // 复制 controller
        String originControllerPath = CONTROLLER_PATH + originClassName + "Controller.java";
        String copyControllerPath = CONTROLLER_PATH + copyClassName + "Controller.java";
        FileUtil.copy(originControllerPath, copyControllerPath, true);
        // 替换内容
        String controllerStr = FileUtil.readUtf8String(originControllerPath);
        controllerStr = StrUtil.replace(controllerStr, originEntityName, copyEntityName);
        controllerStr = StrUtil.replace(controllerStr, originClassName, copyClassName);
        FileUtil.writeUtf8String(controllerStr, copyControllerPath);
        System.out.println(copyClassName + "Controller 复制成功");

        // 复制 service
        String originServicePath = SERVICE_PATH + originClassName + "Service.java";
        String copyServicePath = SERVICE_PATH + copyClassName + "Service.java";
        FileUtil.copy(originServicePath, copyServicePath, true);
        // 替换内容
        String serviceStr = FileUtil.readUtf8String(originServicePath);
        serviceStr = StrUtil.replace(serviceStr, originEntityName, copyEntityName);
        serviceStr = StrUtil.replace(serviceStr, originClassName, copyClassName);
        FileUtil.writeUtf8String(serviceStr, copyServicePath);
        System.out.println(copyClassName + "Service 复制成功");

        // 复制 mapper
        String originMapperPath = MAPPER_PATH + originClassName + "Mapper.java";
        String copyMapperPath = MAPPER_PATH + copyClassName + "Mapper.java";
        FileUtil.copy(originMapperPath, copyMapperPath, true);
        // 替换内容
        String mapperStr = FileUtil.readUtf8String(originMapperPath);
        mapperStr = StrUtil.replace(mapperStr, ORIGIN_TABLE, COPY_TABLE);
        mapperStr = StrUtil.replace(mapperStr, originEntityName, copyEntityName);
        mapperStr = StrUtil.replace(mapperStr, originClassName, copyClassName);
        FileUtil.writeUtf8String(mapperStr, copyMapperPath);
        System.out.println(copyClassName + "Mapper 复制成功");

        // 复制 mapper.xml
        String originMapperXmlPath = MAPPER_XML_PATH + originClassName + "Mapper.xml";
        String copyMapperXmlPath = MAPPER_XML_PATH + copyClassName + "Mapper.xml";
        FileUtil.copy(originMapperXmlPath, copyMapperXmlPath, true);
        // 替换内容
        String mapperXmlStr = FileUtil.readUtf8String(originMapperXmlPath);
        mapperXmlStr = StrUtil.replace(mapperXmlStr, ORIGIN_TABLE, COPY_TABLE);
        mapperXmlStr = StrUtil.replace(mapperXmlStr, originClassName, copyClassName);
        FileUtil.writeUtf8String(mapperXmlStr, copyMapperXmlPath);
        System.out.println(copyClassName + "Mapper.xml 复制成功");

        // 复制 vue页面
        String originVuePath = VUE_PATH + originClassName + ".vue";
        String copyVuePath = VUE_PATH + copyClassName + ".vue";
        FileUtil.copy(originVuePath, copyVuePath, true);
        // 替换内容
        String vueStr = FileUtil.readUtf8String(originVuePath);
        vueStr = StrUtil.replace(vueStr, originEntityName, copyEntityName);
        FileUtil.writeUtf8String(vueStr, copyVuePath);
        System.out.println(copyClassName + ".vue 复制成功");
    }

}