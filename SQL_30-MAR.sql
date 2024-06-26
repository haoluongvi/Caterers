USE [CatererFood]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 3/30/2024 8:46:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CatererId] [int] NULL,
	[EventDate] [datetime] NULL,
	[NumberOfGuests] [int] NULL,
	[BookingDate] [datetime] NULL,
	[Status] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/30/2024 8:46:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Caterer]    Script Date: 3/30/2024 8:46:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Caterer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Address] [varchar](200) NULL,
	[Phone] [varchar](20) NULL,
	[Email] [varchar](100) NULL,
	[CategoryId] [int] NULL,
	[MinimumGuestCount] [int] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK__Caterer__3214EC07C5BCDF85] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 3/30/2024 8:46:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CatererId] [int] NULL,
	[Title] [varchar](100) NULL,
	[Description] [text] NULL,
	[Price] [float] NULL,
	[Image] [varchar](255) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Message]    Script Date: 3/30/2024 8:46:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SenderId] [int] NULL,
	[RecipientId] [int] NULL,
	[Content] [text] NULL,
	[SentDatetime] [datetime] NULL,
	[IsRead] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/30/2024 8:46:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CatererId] [int] NULL,
	[Total] [float] NULL,
	[PaymentMethod] [varchar](250) NULL,
	[PaymentStatus] [varchar](250) NULL,
	[OrderStatus] [varchar](250) NULL,
	[Created] [datetime] NULL,
	[BookingId] [int] NULL,
 CONSTRAINT [PK__Order__3214EC07C35ABA96] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/30/2024 8:46:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[MenuId] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PasswordResetToken]    Script Date: 3/30/2024 8:46:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasswordResetToken](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Token] [varchar](255) NOT NULL,
	[ExpiryDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 3/30/2024 8:46:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleUser]    Script Date: 3/30/2024 8:46:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleUser](
	[RoleId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTable]    Script Date: 3/30/2024 8:46:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](250) NULL,
	[Password] [varchar](250) NULL,
	[Name] [varchar](100) NULL,
	[Address] [varchar](200) NULL,
	[Phone] [varchar](20) NULL,
	[Email] [varchar](100) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Booking] ON 

INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (2, 7, 1005, CAST(N'2024-04-05T00:00:00.000' AS DateTime), 80, CAST(N'2024-03-28T14:07:43.533' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (3, 8, 1006, CAST(N'2024-04-10T00:00:00.000' AS DateTime), 120, CAST(N'2024-03-28T14:07:43.537' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (4, 9, 1007, CAST(N'2024-04-15T00:00:00.000' AS DateTime), 150, CAST(N'2024-03-28T14:07:43.540' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (5, 10, 1008, CAST(N'2024-04-20T00:00:00.000' AS DateTime), 60, CAST(N'2024-03-28T14:07:43.543' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (6, 11, 1009, CAST(N'2024-04-25T00:00:00.000' AS DateTime), 200, CAST(N'2024-03-28T14:07:43.543' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (7, 12, 1010, CAST(N'2024-04-30T00:00:00.000' AS DateTime), 90, CAST(N'2024-03-28T14:07:43.550' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (8, 13, 1011, CAST(N'2024-05-05T00:00:00.000' AS DateTime), 70, CAST(N'2024-03-28T14:07:43.550' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (9, 14, 1012, CAST(N'2024-05-10T00:00:00.000' AS DateTime), 110, CAST(N'2024-03-28T14:07:43.550' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (10, 15, 1013, CAST(N'2024-05-15T00:00:00.000' AS DateTime), 80, CAST(N'2024-03-28T14:07:43.553' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (11, 16, 1014, CAST(N'2024-05-20T00:00:00.000' AS DateTime), 160, CAST(N'2024-03-28T14:07:43.557' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (12, 17, 1015, CAST(N'2024-05-25T00:00:00.000' AS DateTime), 100, CAST(N'2024-03-28T14:07:43.560' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (13, 18, 1016, CAST(N'2024-06-01T00:00:00.000' AS DateTime), 75, CAST(N'2024-03-28T14:07:43.560' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (14, 19, 1017, CAST(N'2024-06-05T00:00:00.000' AS DateTime), 130, CAST(N'2024-03-28T14:07:43.563' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (15, 20, 1018, CAST(N'2024-06-10T00:00:00.000' AS DateTime), 60, CAST(N'2024-03-28T14:07:43.563' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (16, 21, 1019, CAST(N'2024-06-15T00:00:00.000' AS DateTime), 180, CAST(N'2024-03-28T14:07:43.570' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (17, 22, 1020, CAST(N'2024-06-20T00:00:00.000' AS DateTime), 95, CAST(N'2024-03-28T14:07:43.570' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (18, 23, 1021, CAST(N'2024-06-25T00:00:00.000' AS DateTime), 120, CAST(N'2024-03-28T14:07:43.573' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (19, 24, 1022, CAST(N'2024-06-30T00:00:00.000' AS DateTime), 70, CAST(N'2024-03-28T14:07:43.577' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (20, 25, 1023, CAST(N'2024-07-05T00:00:00.000' AS DateTime), 100, CAST(N'2024-03-28T14:07:43.580' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (1002, 1, 1004, CAST(N'2024-04-24T00:00:00.000' AS DateTime), 67, CAST(N'2024-03-29T13:05:28.693' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (1006, 1, 1008, CAST(N'2024-04-24T00:00:00.000' AS DateTime), 51, CAST(N'2024-03-29T13:11:50.950' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (1007, 1, 1006, CAST(N'2024-04-30T00:00:00.000' AS DateTime), 56, CAST(N'2024-03-29T13:35:17.023' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (1008, 1, 1004, CAST(N'2024-04-25T00:00:00.000' AS DateTime), 51, CAST(N'2024-03-29T14:38:24.750' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (1009, 1, 1019, CAST(N'2024-04-30T00:00:00.000' AS DateTime), 56, CAST(N'2024-03-29T15:13:12.600' AS DateTime), N'Confirmed')
INSERT [dbo].[Booking] ([Id], [UserId], [CatererId], [EventDate], [NumberOfGuests], [BookingDate], [Status]) VALUES (2002, 1, 1006, CAST(N'2024-04-10T00:00:00.000' AS DateTime), 51, CAST(N'2024-03-30T12:50:42.280' AS DateTime), N'Confirmed')
SET IDENTITY_INSERT [dbo].[Booking] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name]) VALUES (1002, N'Appetizers')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1003, N'Main Course')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1004, N'Desserts')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1005, N'Beverages')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1006, N'Salads')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1007, N'Sandwiches')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1008, N'Pizzas')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1009, N'Pasta')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1010, N'Seafood')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1011, N'Vegetarian')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1012, N'Vegan')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1013, N'Gluten-Free')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1014, N'BBQ')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1015, N'Asian Cuisine')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1016, N'Mexican Cuisine')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1017, N'Italian Cuisine')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1018, N'Indian Cuisine')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1019, N'Mediterranean Cuisine')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1020, N'Deli')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (1021, N'Bakery')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Caterer] ON 

INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1004, N'Vendor Food A', N'Address 1', N'123-456-7890', N'vendorfoodA@example.com', 1003, 10, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1005, N'Vendor Food B', N'Address 1', N'123-456-7890', N'vendorfoodB@example.com', 1003, 10, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1006, N'Vendor Food C', N'Address 1', N'123-456-7890', N'vendorfoodC@example.com', 1003, 10, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1007, N'Vendor Food D', N'Address 1', N'123-456-7890', N'vendorfoodD@example.com', 1005, 5, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1008, N'Vendor Food E', N'Address 5', N'123-456-7890', N'vendorfoodE@example.com', 1006, 5, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1009, N'Vendor Food F', N'Address 6', N'123-456-7890', N'vendorfoodF@example.com', 1007, 10, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1010, N'Vendor Food G', N'Address 7', N'123-456-7890', N'vendorfoodG@example.com', 1008, 20, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1011, N'Vendor Food H', N'Address 8', N'123-456-7890', N'vendorfoodH@example.com', 1009, 20, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1012, N'Vendor Food I', N'Address 9', N'123-456-7890', N'vendorfoodI@example.com', 1010, 20, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1013, N'Vendor Food J', N'Address 10', N'123-456-7890', N'vendorfoodJ@example.com', 1011, 10, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1014, N'Vendor Food K', N'Address 11', N'123-456-7890', N'vendorfoodK@example.com', 1012, 5, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1015, N'Vendor Food L', N'Address 12', N'123-456-7890', N'vendorfoodL@example.com', 1013, 10, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1016, N'Vendor Food M', N'Address 13', N'123-456-7890', N'vendorfoodM@example.com', 1014, 20, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1017, N'Vendor Food N', N'Address 14', N'123-456-7890', N'vendorfoodN@example.com', 1015, 30, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1018, N'Vendor Food O', N'Address 15', N'123-456-7890', N'vendorfoodO@example.com', 1016, 30, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1019, N'Vendor Food P', N'Address 16', N'123-456-7890', N'vendorfoodP@example.com', 1017, 30, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1020, N'Vendor Food Q', N'Address 17', N'123-456-7890', N'vendorfoodQ@example.com', 1018, 30, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1021, N'Vendor Food R', N'Address 18', N'123-456-7890', N'vendorfoodR@example.com', 1019, 20, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1022, N'Vendor Food S', N'Address 19', N'123-456-7890', N'vendorfoodS@example.com', 1020, 5, 1)
INSERT [dbo].[Caterer] ([Id], [Name], [Address], [Phone], [Email], [CategoryId], [MinimumGuestCount], [Status]) VALUES (1023, N'Vendor Food T', N'Address 20', N'123-456-7890', N'vendorfoodT@example.com', 1021, 5, 1)
SET IDENTITY_INSERT [dbo].[Caterer] OFF
GO
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (3, 1004, N'Spaghetti Carbonara', N'Description 12', 9.99, N'6d145745d5ea484f9b0bbf31c64d438a.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (4, 1004, N'Chicken Tikka Masala', N'Description 2', 8.99, N'bb1e4272955e419385b28fa01c606402.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (5, 1004, N'Beef Bourguignon', N'Description 3', 7.99, N'7b95d8a2c9234cd2bf447200eb97419a.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (6, 1007, N'Quinoa Salad', N'Description 4', 6.99, N'7b052fdfa7474ad1942a289a5e2e6447.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (7, 1008, N'Margherita Pizza', N'Description 5', 5.99, N'a5a3261dd3274622a2a52d15ad14b308.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (8, 1009, N'Sushi Rolls', N'Description 6', 4.99, N'6b7fff02ee9b47d7ae8857a44703fc78.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (9, 1010, N'Falafel Pita', N'Description 7', 3.99, N'056a5fecc7bb45feb38d1812fc829e5a.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (10, 1011, N'Seafood Paella', N'Description 8', 2.99, N'1e7f9aa1157742a687403b0df7ba40ab.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (11, 1012, N'Mushroom Risotto', N'Description 9', 1.99, N'6a1b68faae9b4362b3202bd543861f10.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (12, 1013, N'Tofu Stir-Fry', N'Description 10', 10.99, N'4a1e92052c6a4221bc22e1561e0f6163.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (13, 1014, N'Lamb Rogan Josh', N'Description 11', 11.99, N'73eba98299e749afaef53d99b38ad19a.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (14, 1015, N'Butternut Squash Soup', N'Description 12', 12.99, N'c683fdd05a634128829f83c7ca8bc8c7.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (15, 1016, N'Coq au Vin', N'Description 13', 13.99, N'2e0e4307f9424846bbb828f4a1276543.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (16, 1017, N'Peking Duck', N'Description 14', 14.99, N'9d2e7250ba45462dbce1603df433921d.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (17, 1018, N'Ratatouille', N'Description 15', 15.99, N'5ba6cd9980a94bd3a3e1952852fb9989.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (18, 1019, N'Shrimp Scampi', N'Description 16', 16.99, N'd4e6e6265424415799dbf22316bba559.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (19, 1020, N'Bibimbap', N'Description 17', 17.99, N'1ccdec33da9349ceb1dacdfc0b94f5aa.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (20, 1021, N'Fish and Chips', N'Description 18', 18.99, N'9183a17817f34d01951f25fc670fa4e3.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (21, 1022, N'Empanadas', N'Description 19', 19.99, N'fee99d215797404089183aacc8d35213.jpg', NULL)
INSERT [dbo].[Menu] ([Id], [CatererId], [Title], [Description], [Price], [Image], [Status]) VALUES (22, 1023, N'Menu 20', N'Description 20', 20.99, N'5164eec36c254b8fb75f442a28351fd0.jpg', NULL)
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO
SET IDENTITY_INSERT [dbo].[Message] ON 

INSERT [dbo].[Message] ([Id], [SenderId], [RecipientId], [Content], [SentDatetime], [IsRead]) VALUES (2, 2, 1, N'I am fine, thank you! And you?', CAST(N'2024-03-22T13:49:29.290' AS DateTime), 0)
INSERT [dbo].[Message] ([Id], [SenderId], [RecipientId], [Content], [SentDatetime], [IsRead]) VALUES (8, 2, 1, N'See you then!', CAST(N'2024-03-22T13:49:29.290' AS DateTime), 0)
INSERT [dbo].[Message] ([Id], [SenderId], [RecipientId], [Content], [SentDatetime], [IsRead]) VALUES (12, 2, 1, N'Perfect. See you tomorrow.', CAST(N'2024-03-22T13:49:29.290' AS DateTime), 0)
INSERT [dbo].[Message] ([Id], [SenderId], [RecipientId], [Content], [SentDatetime], [IsRead]) VALUES (20, 2, 1, N'Just sent. Check your email.', CAST(N'2024-03-22T13:49:29.290' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Message] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (9, 1, 1004, 50, N'1', N'1', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (10, 1, 1005, 75, N'2', N'1', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (11, 1, 1006, 60, N'1', N'1', N'0', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (12, 1, 1007, 100, N'2', N'1', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (13, 1, 1008, 45, N'1', N'0', N'0', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (14, 1, 1009, 90, N'2', N'1', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (15, 1, 1010, 70, N'1', N'1', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (16, 1, 1011, 80, N'2', N'0', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (17, 1, 1012, 55, N'1', N'1', N'0', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (18, 1, 1013, 65, N'2', N'1', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (19, 1, 1014, 95, N'1', N'1', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (20, 1, 1015, 50, N'2', N'0', N'0', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (21, 1, 1016, 75, N'1', N'1', N'0', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (22, 1, 1017, 60, N'2', N'1', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (23, 1, 1018, 100, N'1', N'0', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (24, 1, 1019, 45, N'2', N'1', N'0', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (25, 1, 1020, 90, N'1', N'1', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (26, 1, 1021, 70, N'2', N'1', N'0', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (27, 1, 1022, 80, N'1', N'0', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
INSERT [dbo].[Order] ([Id], [UserId], [CatererId], [Total], [PaymentMethod], [PaymentStatus], [OrderStatus], [Created], [BookingId]) VALUES (28, 1, 1023, 55, N'2', N'1', N'1', CAST(N'2024-03-21T05:59:32.800' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (1, 9, 3, 2, 10)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (2, 9, 4, 1, 15)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (3, 9, 5, 3, 12)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (4, 9, 6, 2, 8)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (5, 9, 7, 1, 20)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (6, 10, 8, 4, 10)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (7, 10, 9, 2, 15)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (8, 10, 10, 1, 12)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (9, 17, 11, 3, 8)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (10, 18, 12, 1, 18)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (11, 19, 13, 2, 10)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (12, 20, 14, 1, 15)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (13, 21, 15, 3, 12)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (14, 22, 16, 2, 8)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (15, 23, 17, 1, 20)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (16, 24, 18, 4, 10)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (17, 25, 19, 2, 15)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (18, 26, 20, 1, 12)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (19, 27, 21, 3, 8)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [MenuId], [Quantity], [Price]) VALUES (20, 28, 22, 1, 18)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[PasswordResetToken] ON 

INSERT [dbo].[PasswordResetToken] ([Id], [UserId], [Token], [ExpiryDate]) VALUES (3, 14, N'815737f8-4273-4f81-9c14-4f84bdb9c786', CAST(N'2024-03-26T16:02:02.213' AS DateTime))
INSERT [dbo].[PasswordResetToken] ([Id], [UserId], [Token], [ExpiryDate]) VALUES (10, 16, N'09786252-b756-4d58-9380-9e94969f2d5b', CAST(N'2024-03-27T13:15:19.327' AS DateTime))
SET IDENTITY_INSERT [dbo].[PasswordResetToken] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name], [Status]) VALUES (1, N'Admin', 1)
INSERT [dbo].[Role] ([Id], [Name], [Status]) VALUES (2, N'Caterer', 1)
INSERT [dbo].[Role] ([Id], [Name], [Status]) VALUES (3, N'Customer', 1)
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (1, 1, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (1, 2, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (1, 7, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (1, 11, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (1, 12, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (1, 16, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (2, 2, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (2, 4, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 2, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 7, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 9, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 12, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 18, NULL)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 19, NULL)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 20, NULL)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 21, NULL)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 22, NULL)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 23, NULL)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 26, 1)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 28, NULL)
INSERT [dbo].[RoleUser] ([RoleId], [UserId], [Status]) VALUES (3, 29, 1)
GO
SET IDENTITY_INSERT [dbo].[UserTable] ON 

INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (1, N'admin', N'$2b$10$47AUi3AKeU.F0HEgrjSAY.bmZ2QLJOiWs38XafNDg8RrqhoxPy9.u', N'Admin', N'123 ABC', N'0907685473', N'admin@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (2, N'user1', N'password1', N'User One', N'Address 1', N'Phone 1', N'email1@example.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (3, N'user2', N'password2', N'User Two', N'Address 2', N'Phone 2', N'email2@example.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (4, N'caterer', N'$2b$10$47AUi3AKeU.F0HEgrjSAY.bmZ2QLJOiWs38XafNDg8RrqhoxPy9.u', N'Caterer', N'456 Caterer', N'0909888880', N'caterer@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (5, N'customer', N'$2b$10$47AUi3AKeU.F0HEgrjSAY.bmZ2QLJOiWs38XafNDg8RrqhoxPy9.u', N'Customer', N'789 Cus', N'0909888999', N'cus@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (7, N'test01', N'$2b$10$Kopo1p6FVLr2Ax2qVydpbOp4cVVuluq71ZekE72oImcmudmOdMLfa', N'Test01', N'123 Test01', N'0908999000', N'test01@gmail.com', 0)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (8, N'test023', N'$2b$10$ORvkpAE2d4p7jljm3hA9Xe9hvL8F6nPN1SDOYydSWH.UXogMJAX9y', N'Test02', N'123 test0222', N'0909990099', N'test02@gmail.com', 0)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (9, N'hao', N'$2b$10$mEXIMum1AQdwZSdXb1/ovux9klB6gK3nLaFRiAD6XuE6UODh1zape', N'HAO', N'123 456 Co Giang q1', N'0909090999', N'hao@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (10, N'test1234', N'$2b$10$icdZjGWWbn/5OjQ58INvnezs8G9s.368Bx/SrR9bnLCk6WA8kQpGK', N'Test123', N'123 TEST123', N'090909998', N'12a@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (11, N'abc', N'$2b$10$Yx/3.ift86Mlh1R824SAaOGW47cC.UZx6ErJQYBgxvCdyLtiOrwii', N'ABC', N'123 ABC', N'90909808', N'abc@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (12, N'cus123', N'$2b$10$NUkyr6Ajb.NpiOLAvV9s3eGYnL8DQecpMbGUd0/ayXL.hbfum4DWG', N'Cus123', N'21 Cus', N'765765756', N'cus123@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (13, N'cus003', N'$2b$10$7kpxb9sDhtIfc5OTI.VXAe6icXE/FBjQSqz1zmYkKHcwa1JaayG/a', N'Cus003', N'123 cus003', N'09099999', N'cus003@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (14, N'haoluong1', N'$2b$10$ne0PxHrH.H3KIiJ7Clx/cOHCm8ObNXwIsl.7lw3WNXLIKt.7xeKh2', N'HAO LUONG', N'123 nguyen thai hoc', N'0907685473', N'a1@outlook.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (15, N'abc1', N'$2b$10$7YH1N.NoUnorb1GhapL2ReO5Rb..ArxbvnVdyg1yOz2LoX0zPYyBa', N'abc1', N'123 abc1', N'545354353453', N'abc@outlook.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (16, N'a1', N'$2b$10$3JRx8Q9UkTPGHogOhTJdN.sW6zsuEBOElH8Bn46KYYmwf335NGtCu', N'A1', N'123 nguyen thai hoc', N'0907685473', N'abchhkh@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (17, N'a2', N'$2b$10$8ZEUgtQeQCnPjcUYJAYHJuF2jssbIuHz7Ufm0dNteKp4o1FZFD9ZC', N'A2', N'12 A2', N'321321', N'a2@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (18, N'a34', N'$2b$10$cqtJjHraUznGwmOtF40Kceo1uBJleLlIeRGbSm.4Gu07veDdlzlVe', N'A34', N'123 ABH', N'808080', N'luod@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (19, N'a36', N'$2b$10$.k8Aqv4lXfsLriUtXJS1AunWx9drDahsj00ycwlnC/2ssOQmV0FyC', N'A36', N'1H hdskhdks', N'32323e3342', N'ww@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (20, N'a90', N'$2b$10$uuHEaOH6NHdaeCyXWGGbNunla1EPTbzPggwdZ2ALwv/nXS4b/ORbG', N'A90', N'11 hkhk', N'7979797', N'a390@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (21, N'ah90', N'$2b$10$ysI91/8kq2PZ6iiyoPGL8uUxtCJIdqMi6zpeU/qVOHZf6DcSoycim', N'ah90', N'13c ah90', N'434343434', N'ah90@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (22, N'hao100', N'$2b$10$ygGTJ5ijTtdnZQE3EaTJqeBXVAB.37fEBiWC9Z052nYpcMSsdzQzS', N'hao100', N'12 hao100', N'3242342342', N'111o@outlook.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (23, N'hao101', N'$2b$10$UHE8IknQ.mHMJm00vXlmUur.v6kay4xE.TbtjjpEusxYTqxkuOCBO', N'hao101', N'112 hao101', N'321321312', N'hao101@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (24, N'hao105', N'$2b$10$Z8KZObtI3478hOY4qXN6ee3SxKXhIZn0lsmLimftj2tWVZcng8zRm', N'hao105', N'112 hao105', N'6436565464', N'hao105@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (25, N'hao106', N'$2b$10$XOBE5PZlf.JLIjtyt8m/O.D6xkfamzkI98PxeZcLLpNKs74NfgMwG', N'hao106', N'112 hao106', N'6436565464', N'hao106@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (26, N'haoabc', N'$2b$10$xOgh2F3.0s7cal8.veowYuVib7yPcwyBVBKZhzw0/wpMGJ39Dk5JO', N'haoabc', N'112 haoabc', N'42432432423', N'haoabc@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (27, N'haoluong2', N'$2b$10$rcsP9P6.cY9DT85DTETinuBy/zo1HO0NV2nWoroiVPve9QgBikd.i', N'haoluong2', N'12 dffsd', N'43535435435', N'haoluong2@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (28, N'haoluong3', N'$2b$10$9MO9eJVMsZppvtwDcdP0k.ZdAn0IGmEB7izKwT/3JTT3AE7UglHrW', N'haoluong3', N'12 dsfsfsd', N'23131231231', N'haoluong3@gmail.com', 1)
INSERT [dbo].[UserTable] ([Id], [Username], [Password], [Name], [Address], [Phone], [Email], [Status]) VALUES (29, N'haoluong4', N'$2b$10$kooClJsqQsGh8APeuBLT4es6KgWWQNaryxsUfPFc2fzYcRTBJgRQW', N'haoluong4', N'12 grgdf', N'34343443', N'luongvihao@outlook.com', 1)
SET IDENTITY_INSERT [dbo].[UserTable] OFF
GO
ALTER TABLE [dbo].[Booking] ADD  DEFAULT (getdate()) FOR [BookingDate]
GO
ALTER TABLE [dbo].[Caterer] ADD  CONSTRAINT [DF__Caterer__minimum__06CD04F7]  DEFAULT ((0)) FOR [MinimumGuestCount]
GO
ALTER TABLE [dbo].[Caterer] ADD  CONSTRAINT [DF__Caterer__Status__4D94879B]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Menu] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Message] ADD  DEFAULT (getdate()) FOR [SentDatetime]
GO
ALTER TABLE [dbo].[Message] ADD  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF__Order__Created__60A75C0F]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[Role] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[UserTable] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD FOREIGN KEY([CatererId])
REFERENCES [dbo].[Caterer] ([Id])
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserTable] ([Id])
GO
ALTER TABLE [dbo].[Caterer]  WITH CHECK ADD  CONSTRAINT [FK_Caterer_Category1] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Caterer] CHECK CONSTRAINT [FK_Caterer_Category1]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_Caterer] FOREIGN KEY([CatererId])
REFERENCES [dbo].[Caterer] ([Id])
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK_Menu_Caterer]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD FOREIGN KEY([RecipientId])
REFERENCES [dbo].[UserTable] ([Id])
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD FOREIGN KEY([SenderId])
REFERENCES [dbo].[UserTable] ([Id])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Booking] FOREIGN KEY([BookingId])
REFERENCES [dbo].[Booking] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Booking]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Caterer] FOREIGN KEY([CatererId])
REFERENCES [dbo].[Caterer] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Caterer]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_UserTable] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserTable] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_UserTable]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Menu] FOREIGN KEY([MenuId])
REFERENCES [dbo].[Menu] ([Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Menu]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[PasswordResetToken]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserTable] ([Id])
GO
ALTER TABLE [dbo].[RoleUser]  WITH CHECK ADD  CONSTRAINT [FK_RoleUser_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[RoleUser] CHECK CONSTRAINT [FK_RoleUser_Role]
GO
ALTER TABLE [dbo].[RoleUser]  WITH CHECK ADD  CONSTRAINT [FK_RoleUser_UserTable] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserTable] ([Id])
GO
ALTER TABLE [dbo].[RoleUser] CHECK CONSTRAINT [FK_RoleUser_UserTable]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [CHK_BookingDate] CHECK  ((datediff(day,getdate(),[EventDate])>=(7)))
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [CHK_BookingDate]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD CHECK  (([NumberOfGuests]>=(50)))
GO
