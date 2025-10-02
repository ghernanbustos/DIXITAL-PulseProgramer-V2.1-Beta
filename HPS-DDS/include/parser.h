/*
 * 	File: parser.h
 *
 *  Description: 	Parse function use to read a programSeq.txt file.
 *  The program file has a defined format. The parameters are Fetched
 *  and loaded in FPGA buffers memories.
 *  The program file consist in a parameter preload and then
 *  the sequential software loaded in program buffer which has the information
 *  to access at different buffers.
 *
 *  Project:     DIXITAL - Pulse programmer for NMR applications.
 *  Developer:   Guillermo Hernan Bustos
 *  Company:     Instituto de Fisica Enrique Gaviola - FAMAF U.N.C
 *  Email:       ghernanbustos@gmail.com
 *
 *   Copyright (C) 2024  Guillermo H. Bustos.
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
*/

#ifndef PARSER_H
#define PARSER_H

int parse_file(const char *fileName);

#endif // PARSER_H
