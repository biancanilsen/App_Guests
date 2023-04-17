import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { GuestGrpcServerController } from './app/controller/guest.grpc.server.controller';
import { GuestModule } from './app/modules/guest.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [ConfigModule.forRoot(),
  TypeOrmModule.forRoot({
    type: 'postgres',
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    database: process.env.DB_DATABASE,
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    synchronize: true,
    entities: [__dirname + '/**/*.entity{.js,.ts}'],
  }),
    GuestModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
//create env with postgress