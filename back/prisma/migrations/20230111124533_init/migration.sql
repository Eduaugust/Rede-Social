/*
  Warnings:

  - You are about to drop the column `connectId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Connections` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_connectId_fkey";

-- DropIndex
DROP INDEX "User_connectId_key";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "connectId",
ADD COLUMN     "adj" INTEGER[],
ADD COLUMN     "type" TEXT[];

-- DropTable
DROP TABLE "Connections";
