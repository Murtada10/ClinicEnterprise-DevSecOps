/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[DoctorId] [int] NOT NULL,
	[ScheduledDate] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[EndTime] [datetime2](7) NOT NULL,
	[StartTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Appointments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClinicRooms]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClinicRooms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomNumber] [nvarchar](max) NOT NULL,
	[IsAvailable] [bit] NOT NULL,
	[DepartmentId] [int] NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ClinicRooms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Specialization] [nvarchar](max) NOT NULL,
	[LicenseNumber] [nvarchar](max) NOT NULL,
	[ConsultationFee] [decimal](18, 2) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[PhoneNumber] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Doctors] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoctorShifts]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorShifts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DoctorId] [int] NOT NULL,
	[DayOfWeek] [int] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_DoctorShifts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentId] [int] NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[AmountPaid] [decimal](18, 2) NOT NULL,
	[PaymentMethod] [int] NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[DueDate] [datetime2](7) NOT NULL,
	[IssueDate] [datetime2](7) NOT NULL,
	[PatientId] [int] NOT NULL,
 CONSTRAINT [PK_Invoices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicalRecords]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalRecords](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[Diagnosis] [nvarchar](max) NOT NULL,
	[KnownAllergies] [nvarchar](max) NOT NULL,
	[ClinicalNotes] [nvarchar](max) NOT NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_MedicalRecords] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medications]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Dosage] [nvarchar](max) NOT NULL,
	[Manufacturer] [nvarchar](max) NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Medications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateOfBirth] [datetime2](7) NOT NULL,
	[Bloodtype] [nvarchar](max) NOT NULL,
	[MedicalHistorySummary] [nvarchar](max) NOT NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[PhoneNumber] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NULL,
 CONSTRAINT [PK_Patients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentTransactions]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentTransactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceId] [int] NOT NULL,
	[AmountPaid] [decimal](18, 2) NOT NULL,
	[Method] [int] NOT NULL,
	[TransactionDate] [datetime2](7) NOT NULL,
	[ReferenceNumber] [nvarchar](max) NOT NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PaymentTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prescriptions]    Script Date: 11/21/2026 9:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prescriptions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[MedicationId] [int] NOT NULL,
	[DosageInstructions] [nvarchar](max) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[AppointmentId] [int] NULL,
	[CreateAt] [datetime2](7) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[ModifiedAt] [datetime2](7) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Prescriptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_Appointments_DoctorId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Appointments_DoctorId] ON [dbo].[Appointments]
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Appointments_PatientId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Appointments_PatientId] ON [dbo].[Appointments]
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClinicRooms_DepartmentId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClinicRooms_DepartmentId] ON [dbo].[ClinicRooms]
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Doctors_DepartmentId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Doctors_DepartmentId] ON [dbo].[Doctors]
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DoctorShifts_DoctorId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_DoctorShifts_DoctorId] ON [dbo].[DoctorShifts]
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Invoices_AppointmentId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Invoices_AppointmentId] ON [dbo].[Invoices]
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MedicalRecords_PatientId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_MedicalRecords_PatientId] ON [dbo].[MedicalRecords]
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PaymentTransactions_InvoiceId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_PaymentTransactions_InvoiceId] ON [dbo].[PaymentTransactions]
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Prescriptions_AppointmentId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Prescriptions_AppointmentId] ON [dbo].[Prescriptions]
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Prescriptions_MedicationId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Prescriptions_MedicationId] ON [dbo].[Prescriptions]
(
	[MedicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Prescriptions_PatientId]    Script Date: 11/21/2026 9:34:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Prescriptions_PatientId] ON [dbo].[Prescriptions]
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [EndTime]
GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [StartTime]
GO
ALTER TABLE [dbo].[Doctors] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsActive]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [DueDate]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [IssueDate]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ((0)) FOR [PatientId]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_Doctors_DoctorId] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_Doctors_DoctorId]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_Patients_PatientId] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_Patients_PatientId]
GO
ALTER TABLE [dbo].[ClinicRooms]  WITH CHECK ADD  CONSTRAINT [FK_ClinicRooms_Departments_DepartmentId] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([Id])
GO
ALTER TABLE [dbo].[ClinicRooms] CHECK CONSTRAINT [FK_ClinicRooms_Departments_DepartmentId]
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD  CONSTRAINT [FK_Doctors_Departments_DepartmentId] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Doctors] CHECK CONSTRAINT [FK_Doctors_Departments_DepartmentId]
GO
ALTER TABLE [dbo].[DoctorShifts]  WITH CHECK ADD  CONSTRAINT [FK_DoctorShifts_Doctors_DoctorId] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DoctorShifts] CHECK CONSTRAINT [FK_DoctorShifts_Doctors_DoctorId]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [FK_Invoices_Appointments_AppointmentId] FOREIGN KEY([AppointmentId])
REFERENCES [dbo].[Appointments] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_Appointments_AppointmentId]
GO
ALTER TABLE [dbo].[MedicalRecords]  WITH CHECK ADD  CONSTRAINT [FK_MedicalRecords_Patients_PatientId] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MedicalRecords] CHECK CONSTRAINT [FK_MedicalRecords_Patients_PatientId]
GO
ALTER TABLE [dbo].[PaymentTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactions_Invoices_InvoiceId] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[Invoices] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PaymentTransactions] CHECK CONSTRAINT [FK_PaymentTransactions_Invoices_InvoiceId]
GO
ALTER TABLE [dbo].[Prescriptions]  WITH CHECK ADD  CONSTRAINT [FK_Prescriptions_Appointments_AppointmentId] FOREIGN KEY([AppointmentId])
REFERENCES [dbo].[Appointments] ([Id])
GO
ALTER TABLE [dbo].[Prescriptions] CHECK CONSTRAINT [FK_Prescriptions_Appointments_AppointmentId]
GO
ALTER TABLE [dbo].[Prescriptions]  WITH CHECK ADD  CONSTRAINT [FK_Prescriptions_Medications_MedicationId] FOREIGN KEY([MedicationId])
REFERENCES [dbo].[Medications] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Prescriptions] CHECK CONSTRAINT [FK_Prescriptions_Medications_MedicationId]
GO
ALTER TABLE [dbo].[Prescriptions]  WITH CHECK ADD  CONSTRAINT [FK_Prescriptions_Patients_PatientId] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Prescriptions] CHECK CONSTRAINT [FK_Prescriptions_Patients_PatientId]
GO

