use BDPedidoIFSP

--Inserindo na tabela vendedores
insert into vendedores values
('João Silva', 3500.50, '1'),
('Maria Oliveira', 4100.00, '3'),
('Carlos Pereira', 3850.75, '4'),
('Ana Souza', 4500.00, '2');

--Inserindo na tabela clientes
insert into clientes values
('Fernanda Lima', '102205', 3200.90, 1),
('Roberto Alves', 'Gomes', 8750.00, NULL),
('Mariana Costa', '250', 1980.55, 2570),
('Lucas Andrade', '300555', 55000.00, 0);

--inserindo na tabela pedidos
insert into pedidos values
('2024-01-20T10:00:00', 1, 1),
('2024-01-20T11:30:00', 4, 2),
('2024-01-21T09:15:00', 1005, 4),
('2024-01-22T14:00:00', 1008, 3);

select * from StatusProduto
--inserindo na tabela StatusProduto
insert into StatusProduto values
(5, 'Disponível em Estoque'),
(6, 'Sob Encomenda'),
(7, 'Aguardando Reposição'),
(8, 'Oferta Especial');


--inserindo na tabela TBColaborador