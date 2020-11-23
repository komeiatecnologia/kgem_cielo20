module KCielo
  module Pagador
    STATUS = {
       0 => 'Não finalizada',
       1 => 'Autorizada',
       2 => 'Pagamento confirmado',
       3 => 'Negado',
      10 => 'Cancelado',
      11 => 'Reembolsado',
      12 => 'Pendente',
      13 => 'Abortado',
      20 => 'Agendado'
    }

    REASON_MESSAGE = {
       0 => 'Sucesso',
       1 => 'Afiliação não encontrada',
       2 => 'Saldo insuficiente',
       3 => 'Cartão de crédito não encontrado',
       4 => 'A conexão com a operadora de cartões falhou',
       5 => 'Tipo de transação inválido',
       6 => 'Plano de pagamento inválido',
       7 => 'Negado',
       8 => 'Agendado',
       9 => 'Aguardando',
      10 => 'Autenticado',
      11 => 'Não autenticado',
      12 => 'Problemas com o cartão de crédito',
      13 => 'Cartão de crédito cancelado',
      14 => 'Cartão de crédito bloqueado',
      15 => 'Cartão de crédito expirado',
      16 => 'Abortado por suspeita de fraude',
      17 => 'Análise antifraude falhou',
      18 => 'Tente Novamente',
      19 => 'Valor inválido',
      20 => 'Problemas com a emissora',
      21 => 'Número de cartão de crédito inválido',
      22 => 'Conexão expirou',
      23 => 'Cartão protegido não está ativo',
      24 => 'O meio de pagamento não está ativo',
      98 => 'Requisição inválida',
      99 => 'Erro desconhecido'
    }

    ERROR_MESSAGE = {
      100 => "RequestId é obrigatório",
      101 => "MerchantId é obrigatório",
      102 => "Payment Type é obrigatório",
      103 => "Payment Type deve conter somente letras",
      104 => "Customer Identity é obrigatório",
      105 => "Customer Name é obrigatório",
      106 => "Transaction ID é obrigatório",
      107 => "É obrigatório informar o número do cartão de crédito, Token ou Alias",
      108 => "O Amount deve ser maior ou igual a zero",
      109 => "Payment Currency é obrigatório",
      110 => "Payment Currency inválido",
      111 => "Payment Country é obrigatório",
      112 => "Payment Country inválido",
      113 => "Payment Code inválido",
      114 => "MerchantId não está em formato válido",
      115 => "The provided MerchantId was not found",
      117 => "O Titular do cartão é obrigatório",
      118 => "Número do cartão de crédito é obrigatório",
      119 => "Informe ao menos um Payment",
      120 => "Não são permitidas requisições desse IP, verifique se o seu IP está White List",
      121 => "Customer é obrigatório",
      122 => "MerchantOrderId é obrigatório",
      123 => "As parcelas devem ser igual ou maior que 1",
      124 => "Credit Card é obrigatório",
      125 => "Data de expiração do cartão é obrigatório",
      126 => "Data de expiração do cartão de crédito inválida",
      127 => "É obrigatório informar o número do cartão de crédito, Token ou Alias",
      128 => "O número do cartão excedeu o tamanho máximo permitido",
      129 => "Afiliação não encontrada",
      130 => "Não foi possível obter o número do cartão",
      131 => "MerchantKey é obrigatório",
      132 => "MerchantKey é inválida",
      133 => "O tipo de pagamento escolhido não é suportado pelo provider informado",
      134 => "FingerPrint excedeu o tamanho máximo permitido",
      135 => "MerchantDefinedFieldValue excedeu o tamanho máximo permitido",
      136 => "ItemDataName excedeu o tamanho máximo permitido",
      137 => "ItemDataSKU excedeu o tamanho máximo permitido",
      138 => "PassengerDataName excedeu o tamanho máximo permitido",
      139 => "PassengerDataStatus excedeu o tamanho máximo permitido",
      140 => "PassengerDataEmail excedeu o tamanho máximo permitido",
      141 => "PassengerDataPhone excedeu o tamanho máximo permitido",
      142 => "TravelDataRoute excedeu o tamanho máximo permitido",
      143 => "TravelDataJourneyType excedeu o tamanho máximo permitido",
      144 => "TravelLegDataDestination excedeu o tamanho máximo permitido",
      145 => "TravelLegDataOrigin excedeu o tamanho máximo permitido",
      146 => "Código de segurança excedeu o tamanho máximo permitido",
      147 => "O nome da rua informado excedeu o tamanho máximo permitido",
      148 => "O número informado no endereço excedeu o tamanho máximo permitido",
      149 => "O complemento do endereço excedeu o tamanho máximo permitido",
      150 => "O Cep informado excedeu o tamanho máximo permitido",
      151 => "O nome da cidade informada excedeu o tamanho máximo permitido",
      152 => "O estado informado no endereço excedeu o tamanho máximo permitido",
      153 => "O país excedeu o tamanho máximo permitido",
      154 => "O distrito informado no endereço excedeu o tamanho máximo permitido",
      155 => "O nome do cliente informado excedeu o tamanho máximo permitido",
      156 => "A identificação do cliente excedeu o tamanho máximo permitido",
      157 => "Customer IdentityType excedeu o tamanho máximo permitido",
      158 => "O email informado excedeu o tamanho máximo permitido",
      159 => "ExtraData Name excedeu o tamanho máximo permitido",
      160 => "ExtraData Value excedeu o tamanho máximo permitido",
      161 => "As instruções do boleto excedeu o tamanho máximo permitido",
      162 => "O demonstrativo do boleto excedeu o tamanho máximo permitido",
      163 => "Return Url é obrigatório",
      164 => "A URL de retorno informada é inválida",
      166 => "AuthorizeNow é obrigatório",
      167 => "Antifraude não configurado",
      168 => "Pagamento recorrente não encontrado",
      169 => "Pagamento recorrente não está ativo",
      170 => "Cartão Protegido não configurado",
      171 => "Dados da afiliação não enviado",
      172 => "Código credencial é obrigatório",
      173 => "Meio de pagamento não está ativo",
      300 => "MerchantId não encontrado",
      301 => "Não são permitidas requisições deste IP",
      302 => "O MerchantOrderId informado já existe",
      303 => "O OrderId informado não existe",
      304 => "Customer Identity é obrigatório",
      306 => "A chave de loja(MerchantId) informada está bloqueado",
      307 => "Transação não encontrada",
      308 => "Transação não está disponível para captura",
      309 => "O cancelamento não está disponível para essa transação",
      310 => "O pagamento informado não suporta essa operação",
      311 => "Estorno de transações não está ativo para essa chave de loja(MerchantId)",
      312 => "Transação não disponível para estorno",
      313 => "Pagamento recorrente não encontrado",
      314 => "Integração inválida",
      315 => "Não é possível alterar a data do próximo pagamento(NextRecurrency) com pagamento pendente",
      316 => "A próxima recorrência não pode ser uma data passada",
      317 => "Data de recorrência inválida",
      318 => "Nenhuma transação encontrada",
      319 => "Recorrência inteligente não está ativa"
    }

    RETURN_CODE_MESSAGE = {
      '04' => 'Transação não autorizada',
      '05' => 'Transação não autorizada',
      '06' => 'Tente novamente',
      '07' => 'Cartão com restrição',
      '08' => 'Código de segurança inválido',
      '11' => 'Transação autorizada',
      '13' => 'Valor inválido',
      '14' => 'Cartão inválido',
      '15' => 'Banco emissor indisponível',
      '21' => 'Cancelamento não efetuado',
      '41' => 'Cartão com restrição',
      '51' => 'Saldo insuficiente',
      '54' => 'Cartão vencido',
      '57' => 'Transação não permitida',
      '60' => 'Transação não autorizada',
      '62' => 'Transação não autorizada',
      '70' => 'Problemas com o Cartão de Crédito',
      '77' => 'Cartão cancelado',
      '78' => 'Cartão não foi desbloqueado',
      '82' => 'Erro no cartão',
      '91' => 'Banco fora do ar',
      '96' => 'Tente novamente',
      '99' => 'Time out',
      'KE' => 'Transação não autorizada'
    }

    protected
    def credit_card_paid?(status)
      status == 2
    end

    def payment_slip_paid?(status)
      status == 2
    end

    def operation_success?(status)
      [1,2,10,11].include? status
    end

    def transaction_canceled?(status)
      [10,11].include? status
    end
  end
end
