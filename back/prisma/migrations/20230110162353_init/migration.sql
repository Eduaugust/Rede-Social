-- CreateTable
CREATE TABLE "Connections" (
    "id" SERIAL NOT NULL,
    "type" TEXT,

    CONSTRAINT "Connections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "surname" VARCHAR(255) NOT NULL,
    "birthday" VARCHAR(255) NOT NULL,
    "userType" INTEGER NOT NULL,
    "connectId" INTEGER NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_connectId_key" ON "User"("connectId");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_connectId_fkey" FOREIGN KEY ("connectId") REFERENCES "Connections"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
