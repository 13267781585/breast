package lllr.test.breast;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.web.bind.annotation.RestController;


@EnableConfigurationProperties
@SpringBootApplication(scanBasePackages = {"lllr.test.breast"})
@RestController
@MapperScan("lllr.test.breast.dao.mapper")
public class BreastApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(BreastApplication.class, args);
    }

    @Override//为了打包springboot项目
    protected SpringApplicationBuilder configure(
            SpringApplicationBuilder builder) {
        return builder.sources(this.getClass());
    }
}
