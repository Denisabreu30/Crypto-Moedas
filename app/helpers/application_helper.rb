module ApplicationHelper
  def locale
    if I18n.locale == :en
      "Estados Unidos"
    else
      "português do Brasil"
    end
  end

  def data_br(data_us)
      data_us.strftime("%d/%m/%Y")
  end

  def nome_aplicacao
     "CRYPTO WALLET"
  end
  
end
