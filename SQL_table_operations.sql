CREATE TABLE IF NOT EXISTS `patients` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `age` INT NOT NULL,
    `gender` VARCHAR(1) NOT NULL,
    `phone` VARCHAR(15) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `address` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `city_id` INT NOT NULL,
    FOREIGN KEY (`city_id`) REFERENCES `cities`(`id`)
);

CREATE TABLE IF NOT EXISTS `cities` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `state_id` INT NOT NULL,
    FOREIGN KEY (`state_id`) REFERENCES `states`(`id`)
);

CREATE TABLE IF NOT EXISTS `states` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `doctors` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `specialization` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(15) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `address` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `city_id` INT NOT NULL,
    FOREIGN KEY (`city_id`) REFERENCES `cities`(`id`)
);

CREATE TABLE IF NOT EXISTS `appointments` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `patient_id` INT NOT NULL,
    `doctor_id` INT NOT NULL,
    `appointment_date` DATE NOT NULL,
    `appointment_time` TIME NOT NULL,
    `appointment_status` VARCHAR(20) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`patient_id`) REFERENCES `patients`(`id`),
    FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`id`)
);

CREATE TABLE IF NOT EXISTS `prescriptions` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `appointment_id` INT NOT NULL,
    `medicine` TEXT NOT NULL,
    `dosage` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`appointment_id`) REFERENCES `appointments`(`id`)
);

INSERT INTO `states` (`id`, `name`) VALUES
(1, 'Maharashtra'),
(2, 'Karnataka'),
(3, 'Tamil Nadu'),
(4, 'Delhi'),
(5, 'Gujarat');

INSERT INTO `cities` (`id`, `name`, `state_id`) VALUES
(1, 'Mumbai', 1),
(2, 'Pune', 1),
(3, 'Bangalore', 2),
(4, 'Chennai', 3),
(5, 'Delhi', 4),
(6, 'Ahmedabad', 5);

INSERT INTO `patients` (`id`, `name`, `age`, `gender`, `phone`, `email`, `address`, `city_id`) VALUES
(1, 'John Doe', 30, 'M', '9876543210', 'john@mail.com', '123, ABC Street, XYZ Area', 1),
(2, 'Jane Doe', 25, 'F', '9876543211', 'jane@mail.com', '456, DEF Street, UVW Area', 2),
(3, 'Alice Smith', 35, 'F', '9876543212', 'alice@mail.com', '789, GHI Street, RST Area', 3),
(4, 'Bob Brown', 40, 'M', '9876543213', 'bob@mail.com', '101, JKL Street, OPQ Area', 4);

INSERT INTO `doctors` (`id`, `name`, `specialization`, `phone`, `email`, `address`, `city_id`) VALUES
(1, 'Dr. Alex Johnson', 'Cardiologist', '9876543214', 'dr.alex@mail.com', '543, JKL Street, OPQ Area', 1),
(2, 'Dr. Emily Wilson', 'Dermatologist', '9876543215', 'emilyw@mail.com', '765, MNO Street, UVW Area', 2),
(3, 'Dr. Michael Brown', 'Orthopedic', '9876543216', 'drbrown@mail.com', '987, PQR Street, XYZ Area', 3),
(4, 'Dr. Sarah Davis', 'Pediatrician', '9876543217', 'sarah@mail.com', '234, STU Street, RST Area', 4);

INSERT INTO `appointments` (`id`, `patient_id`, `doctor_id`, `appointment_date`, `appointment_time`, `appointment_status`) VALUES
(1, 1, 1, '2021-01-01', '10:00:00', 'completed'),
(2, 2, 2, '2021-01-02', '11:00:00', 'completed'),
(3, 3, 3, '2021-01-03', '12:00:00', 'completed'),
(4, 4, 4, '2021-01-04', '13:00:00', 'completed'),
(5, 1, 2, '2021-01-05', '14:00:00', 'pending'),
(6, 2, 3, '2021-01-06', '15:00:00', 'pending'),
(7, 3, 4, '2021-01-07', '16:00:00', 'cancelled'),
(8, 4, 1, '2021-01-08', '17:00:00', 'pending');

INSERT INTO `prescriptions` (`id`, `appointment_id`, `medicine`, `dosage`) VALUES
(1, 1, 'Medicine 1, Medicine 2', 'Dosage 1, Dosage 2'),
(2, 2, 'Medicine 3, Medicine 4', 'Dosage 3, Dosage 4'),
(3, 3, 'Medicine 5, Medicine 6', 'Dosage 5, Dosage 6'),
(4, 4, 'Medicine 7, Medicine 8', 'Dosage 7, Dosage 8'),
(5, 5, 'Medicine 9, Medicine 10', 'Dosage 9, Dosage 10'),
(6, 6, 'Medicine 11, Medicine 12', 'Dosage 11, Dosage 12'),
(7, 7, 'Medicine 13, Medicine 14', 'Dosage 13, Dosage 14'),
(8, 8, 'Medicine 15, Medicine 16', 'Dosage 15, Dosage 16');

ALTER TABLE `patients` ADD COLUMN `blood_group` VARCHAR(5);

ALTER TABLE `doctors` ADD COLUMN `qualification` VARCHAR(255);

ALTER TABLE `appointments` RENAME COLUMN `appointment_status` TO `status`;

ALTER TABLE `patients` DROP COLUMN `email`;

DELETE FROM `patients` WHERE `id` = 4;

UPDATE `doctors` SET `phone` = '9876543218' WHERE `id` = 4;