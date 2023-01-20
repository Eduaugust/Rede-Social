/*
  Warnings:

  - You are about to drop the `_adj` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_adj" DROP CONSTRAINT "_adj_A_fkey";

-- DropForeignKey
ALTER TABLE "_adj" DROP CONSTRAINT "_adj_B_fkey";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "adj" INTEGER[];

-- DropTable
DROP TABLE "_adj";
