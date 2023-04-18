import { Column, CreateDateColumn, DeleteDateColumn, Entity, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";

@Entity()
export class GuestEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column()
    name: string;

    @Column()
    phone: string;

    @Column()
    email: string;

    @CreateDateColumn({ type: 'timestamptz' })
    createdAt?: Date;

    @UpdateDateColumn({ type: 'timestamptz' })
    updatedAt?: Date;

    @DeleteDateColumn({ type: 'timestamptz' })
    deletedAt?: Date;
}