/*
  Warnings:

  - The values [CONFIRMED] on the enum `Payment_status` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterTable
ALTER TABLE `Booking` MODIFY `bookingStatus` ENUM('PENDING', 'AWAITING_OWNER_APPROVAL', 'FAILED', 'CONFIRMED', 'CANCELLED', 'COMPLETED') NOT NULL;

-- AlterTable
ALTER TABLE `Payment` MODIFY `status` ENUM('PENDING', 'SUCCESS', 'FAILED', 'REFUNDED') NOT NULL;

-- AlterTable
ALTER TABLE `User` ADD COLUMN `isNewUser` BOOLEAN NOT NULL DEFAULT true,
    MODIFY `password` VARCHAR(191) NULL;

-- CreateTable
CREATE TABLE `OTP` (
    `id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `expires` DATETIME(3) NOT NULL,
    `otp` VARCHAR(191) NULL,

    UNIQUE INDEX `OTP_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
