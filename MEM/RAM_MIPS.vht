-- Copyright (C) 1991-2011 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions
-- and other software and tools, and its AMPP partner logic
-- functions, and any output files from any of the foregoing
-- (including device programming or simulation files), and any
-- associated documentation or information are expressly subject
-- to the terms and conditions of the Altera Program License
-- Subscription Agreement, Altera MegaCore Function License
-- Agreement, or other applicable license agreement, including,
-- without limitation, that your use is for the sole purpose of
-- programming logic devices manufactured by Altera and sold by
-- Altera or its authorized distributors.  Please refer to the
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to
-- suit user's needs .Comments are provided in each section to help the user
-- fill out necessary details.
-- ***************************************************************************
-- Generated on "11/01/2016 18:28:15"

-- Vhdl Test Bench template for design  :  RAM_MIPS
--
-- Simulation tool : ModelSim-Altera (VHDL)
--

-- Universidade de Brasilia 2/2016
-- Organizacao e Arquitetura de Computadores
-- Lucas Nascimento Santos Souza - 14/0151010

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY RAM_MIPS_vhd_tst IS
END RAM_MIPS_vhd_tst;
ARCHITECTURE RAM_MIPS_arch OF RAM_MIPS_vhd_tst IS
-- constants
-- signals
SIGNAL address : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL clock : STD_LOGIC;
SIGNAL data : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL q : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL wren : STD_LOGIC;
COMPONENT RAM_MIPS
	PORT (
	address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	clock : IN STD_LOGIC;
	data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	wren : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : RAM_MIPS
	PORT MAP (
-- list connections between master ports and signals
	address => address,
	clock => clock,
	data => data,
	q => q,
	wren => wren
	);

-- CASOS DE TESTE
--
-- 		O testbench deverá gerar os sinais para leitura do conteúdo pré-carregado na RAM e os
-- sinais e dados para escrita da RAM. Os resultados devem ser visualizados no ModelSim-Altera.

init : PROCESS
-- variable declarations
BEGIN
	-- code that executes only once

	-- Lendo a memoria
	for Index in 0 to 255 loop
		Clock <= '0'; wait for 5 ps;

		-- Endereco de acordo com o indice atual do loop
		Address <= std_logic_vector(to_unsigned(Index, 8));

		Clock <= '1'; wait for 5 ps;
	end loop;

	-- Escrevendo na memoria
	WrEn <= '1';

	for Index in 0 to 255 loop
		Clock <= '0'; wait for 5 ps;

		-- Endereco de acordo com o indice atual do loop
		Address <= std_logic_vector(to_unsigned(Index, 8));
		-- Dado para escrita = X"FFFF" & (indice atual do loop)
		Data <= X"FFFF" & std_logic_vector(to_unsigned(Index, 16));

		Clock <= '1'; wait for 5 ps;
	end loop;

WAIT;
END PROCESS init;
always : PROCESS
-- optional sensitivity list
-- (        )
-- variable declarations
BEGIN
        -- code executes for every event on sensitivity list
WAIT;
END PROCESS always;
END RAM_MIPS_arch;
