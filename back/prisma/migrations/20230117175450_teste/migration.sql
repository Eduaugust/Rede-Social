/*
  Warnings:

  - You are about to drop the column `adj` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `birthday` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[name]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[number]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `emailVisible` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nameVisible` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `numberVisible` to the `User` table without a default value. This is not possible if the table is not empty.
  - Made the column `password` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "User" DROP COLUMN "adj",
DROP COLUMN "birthday",
ADD COLUMN     "emailVisible" BOOLEAN NOT NULL,
ADD COLUMN     "nameVisible" BOOLEAN NOT NULL,
ADD COLUMN     "numberVisible" BOOLEAN NOT NULL,
ALTER COLUMN "name" SET DATA TYPE TEXT,
ALTER COLUMN "password" SET NOT NULL,
ALTER COLUMN "password" DROP DEFAULT;

-- CreateTable
CREATE TABLE "_adj" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_adj_AB_unique" ON "_adj"("A", "B");

-- CreateIndex
CREATE INDEX "_adj_B_index" ON "_adj"("B");

-- CreateIndex
CREATE UNIQUE INDEX "User_name_key" ON "User"("name");

-- CreateIndex
CREATE UNIQUE INDEX "User_number_key" ON "User"("number");

-- AddForeignKey
ALTER TABLE "_adj" ADD CONSTRAINT "_adj_A_fkey" FOREIGN KEY ("A") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_adj" ADD CONSTRAINT "_adj_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
