import { Metadata, ServerUnaryCall } from '@grpc/grpc-js';
import { Controller } from '@nestjs/common';
import { GrpcMethod } from '@nestjs/microservices';
import { CreateGuestDto } from '../dto/create-guest.dto';
import { GuestService } from '../service/guest.service';
import { UpdateGuestDto } from '../dto/update-guest.dto';

@Controller('guest')
export class GuestGrpcServerController {

    constructor(private guestService: GuestService) { }

    @GrpcMethod('GuestService', 'Create')
    async Create(data: CreateGuestDto, metadata: Metadata, call: ServerUnaryCall<CreateGuestDto, any>) {
        console.log(data)
        return await this.guestService.store(data);
    }

    @GrpcMethod('GuestService', 'Update')
    async Update(data: UpdateGuestDto, metadata: Metadata, call: ServerUnaryCall<UpdateGuestDto, any>) {
        return await this.guestService.update(data.id, data);
    }

    @GrpcMethod('GuestService', 'Show')
    async Show(data: { id: string }) {
        const { id } = data;
        return await this.guestService.findOneOrFail(id);
    }

    @GrpcMethod('GuestService', 'Index')
    async Index(data) {
        const guests = await this.guestService.findAll();
        return guests;
    }

    @GrpcMethod('GuestService', 'Delete')
    async Delete(data: { id: string }) {
        const { id } = data;
        return await this.guestService.destroy(id);
    }

}
