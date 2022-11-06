package step.learning.ioc;

import com.google.inject.AbstractModule;
import step.learning.services.DataService;
import step.learning.services.MysqlDataService;
import step.learning.services.hash.HashService;
import step.learning.services.hash.Sha1HashService;

public class ConfigModule extends AbstractModule {
    @Override
    protected void configure() {
        // Конфигурация служб-поставщиков
        bind(DataService.class).to(MysqlDataService.class) ;
        bind(HashService.class).to(Sha1HashService.class) ;
    }
}