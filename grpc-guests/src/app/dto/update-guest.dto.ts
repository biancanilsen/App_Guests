import { IsOptional } from "class-validator";

export class UpdateGuestDto {

    @IsOptional()
    id: string;

    @IsOptional()
    name: string;

    @IsOptional()
    phone: string;

    @IsOptional()
    email: string;
}