import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';
import { join } from 'path';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.connectMicroservice<MicroserviceOptions>({
    transport: Transport.GRPC,
    options: {
      url: '172.16.8.73:3001',
      package: 'guest',
      protoPath: join(__dirname, 'app/proto/guest.proto'),
    }
  })

  app.startAllMicroservices()
  await app.listen(3001);
}
bootstrap(); 