/*
  Warnings:

  - You are about to drop the column `paymentMethod` on the `Payment` table. All the data in the column will be lost.
  - The values [CONFIRMED] on the enum `Payment_status` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `userId` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[bookingId]` on the table `Review` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `bookingId` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fullName` to the `Review` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Review` DROP FOREIGN KEY `Review_userId_fkey`;

-- AlterTable
ALTER TABLE `Booking` MODIFY `bookingStatus` ENUM('PENDING', 'AWAITING_OWNER_APPROVAL', 'FAILED', 'CONFIRMED', 'CANCELLED', 'COMPLETED') NOT NULL;

-- AlterTable
ALTER TABLE `Payment` DROP COLUMN `paymentMethod`,
    MODIFY `status` ENUM('PENDING', 'SUCCESS', 'FAILED', 'REFUNDED') NOT NULL;

-- AlterTable
ALTER TABLE `Property` MODIFY `description` VARCHAR(600) NOT NULL,
    MODIFY `address` VARCHAR(300) NOT NULL,
    MODIFY `extraInfo` VARCHAR(400) NULL;

-- AlterTable
ALTER TABLE `Review` DROP COLUMN `userId`,
    ADD COLUMN `avatar` VARCHAR(191) NULL,
    ADD COLUMN `bookingId` VARCHAR(191) NOT NULL,
    ADD COLUMN `fullName` VARCHAR(300) NOT NULL,
    MODIFY `review` VARCHAR(300) NOT NULL;

-- AlterTable
ALTER TABLE `User` DROP COLUMN `password`;

-- CreateTable
CREATE TABLE `OTP` (
    `id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `expires` DATETIME(3) NOT NULL,
    `otp` VARCHAR(191) NULL,

    UNIQUE INDEX `OTP_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Review_bookingId_key` ON `Review`(`bookingId`);

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_bookingId_fkey` FOREIGN KEY (`bookingId`) REFERENCES `Booking`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
