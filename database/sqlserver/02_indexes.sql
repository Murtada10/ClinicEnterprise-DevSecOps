-- ============================================================================
-- Performance & Filtered Indexing Strategy (100,000+ Patients Dataset)
-- Aligns with Soft-Delete (IsDeleted = 0) & EF Core Schema Types
-- ============================================================================

-- 1. Covering Filtered Index for Active Patient Pagination & API Lookups
-- Note: nvarchar(max) columns are placed in INCLUDE to avoid SQL Server Msg 1919
CREATE NONCLUSTERED INDEX IX_Patients_Active_Covering
ON dbo.Patients (IsDeleted, Id)
INCLUDE (FirstName, LastName, DateOfBirth, Bloodtype, PhoneNumber, Email, CreateAt)
WHERE IsDeleted = 0;
GO

-- 2. Right-size PII lookup columns from nvarchar(max) to bounded lengths,
--    then create Filtered B-Tree Seek Indexes for Phone & Email searches
ALTER TABLE dbo.Patients ALTER COLUMN PhoneNumber nvarchar(30) NOT NULL;
ALTER TABLE dbo.Patients ALTER COLUMN Email nvarchar(255) NULL;
GO

CREATE NONCLUSTERED INDEX IX_Patients_PhoneNumber_Active
ON dbo.Patients (PhoneNumber)
INCLUDE (Id, FirstName, LastName, DateOfBirth)
WHERE IsDeleted = 0;
GO

CREATE NONCLUSTERED INDEX IX_Patients_Email_Active
ON dbo.Patients (Email)
INCLUDE (Id, FirstName, LastName)
WHERE IsDeleted = 0 AND Email IS NOT NULL;
GO

-- 3. Filtered Indexes for High-Frequency Clinical & Billing Queries
CREATE NONCLUSTERED INDEX IX_Appointments_ScheduledDate_Active
ON dbo.Appointments (ScheduledDate, Status)
INCLUDE (PatientId, DoctorId, StartTime, EndTime)
WHERE IsDeleted = 0;
GO

CREATE NONCLUSTERED INDEX IX_Invoices_PatientId_Active
ON dbo.Invoices (PatientId, DueDate)
INCLUDE (AppointmentId, TotalAmount, AmountPaid, PaymentMethod)
WHERE IsDeleted = 0;
GO

