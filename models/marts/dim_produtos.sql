with
    stg_categorias as (
        select
            id_categoria
            , nome_categoria
            , descricao_categoria
        from {{ ref('stg_erp__categorias') }}
    )

    , stg_fornecedores as (
        select
            id_fornecedor
            , nome_fornecedor
            , contato_fornecedor
            , contato_funcao
            , endereco_fornecedor
            , cidade_fornecedor
            , regiao_fornecedor
            , pais_fornecedor
            , cep_fornecedor
        from {{ ref('stg_erp__suppliers') }}
    )

    , stg_produtos as (
        select
            id_produto
            , id_fornecedor
            , id_categoria
            , nome_produto
            , quantidade_por_unidade
            , preco_unidade
            , quantidade_em_estoque
            , unidade_por_ordem
            , nivel_abastecimento
            , eh_descontinuado          
        from {{ ref('stg_erp__produtos') }}
    )

    , joined_tabelas as (
        select
            stg_produtos.id_produto
            , stg_produtos.id_fornecedor
            , stg_produtos.id_categoria
            , stg_produtos.nome_produto
            , stg_produtos.quantidade_por_unidade
            , stg_produtos.preco_unidade
            , stg_produtos.quantidade_em_estoque
            , stg_produtos.unidade_por_ordem
            , stg_produtos.nivel_abastecimento
            , stg_produtos.eh_descontinuado 

            , stg_categorias.nome_categoria

            , stg_fornecedores.nome_fornecedor
            , stg_fornecedores.pais_fornecedor
        from stg_produtos
        left join stg_categorias on
            stg_produtos.id_categoria = stg_categorias.id_categoria
        left join stg_fornecedores on
            stg_produtos.id_fornecedor = stg_fornecedores.id_fornecedor
    )
select *
from joined_tabelas