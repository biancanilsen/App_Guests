import { Module } from '@nestjs/common';
import { GuestGrpcServerController } from '../controller/guest.grpc.server.controller';
import { GuestService } from '../service/guest.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GuestEntity } from '../entities/guest.entity';

@Module({
    imports: [TypeOrmModule.forFeature([GuestEntity])],
    controllers: [GuestGrpcServerController],
    providers: [GuestService],
})
export class GuestModule { }
