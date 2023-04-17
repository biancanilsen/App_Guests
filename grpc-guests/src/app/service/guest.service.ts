import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';

import { FindManyOptions, Like, Repository } from 'typeorm';
import { GuestEntity } from '../entities/guest.entity';
import { CreateGuestDto } from '../dto/create-guest.dto';
import { UpdateGuestDto } from '../dto/update-guest.dto';


@Injectable()
export class GuestService {

    constructor(
        @InjectRepository(GuestEntity)
        private readonly guestRepository: Repository<GuestEntity>,
    ) { }

    async findAll() {
        const options: FindManyOptions = {
            // order: { createdAt: 'DESC' },
        };
        try {
            const guests = await this.guestRepository.find({
                select: ['id', 'name', 'phone', 'email']
            })
            let data = {
                guests
            }
            console.log(data);
            return data;
        } catch (error) {
            throw new NotFoundException(error.message);
        }
    }

    async findOneOrFail(id: string) {
        try {
            return await this.guestRepository.findOneBy({ id });
        } catch {
            throw new NotFoundException();
        }
    }

    // async findByName(name: string) {
    //     try {
    //         return await this.guestRepository.query(`select * from movie_entity me where name ILIKE'%${name}%'`)
    //     } catch (error) {
    //         throw new NotFoundException(error.message);
    //     }
    // }

    async store(data: CreateGuestDto) {
        try {
            const guest = this.guestRepository.create(data);
            return await this.guestRepository.save(guest);
        } catch (error) {
            throw new NotFoundException(error.message);
        }
    }

    async update(id: string, data: UpdateGuestDto) {
        try {
            await this.guestRepository.findOneBy({ id });
        } catch (error) {
            throw new NotFoundException(error.message);
        }
        return await this.guestRepository.save({ id: id, ...data });
    }

    async destroy(id: string) {
        try {
            await this.guestRepository.findOneBy({ id });
        } catch {
            throw new NotFoundException();
        }
        const deleted = await this.guestRepository.softRemove({ id });

        if (deleted) {
            return true;
        }
        return false;
    }



}