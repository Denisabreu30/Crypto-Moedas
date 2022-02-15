namespace :dev do
  desc "configurar o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("apagando BD...") { %x(rails db:drop) }
      show_spinner("criando BD...") { %x(rails db:create)}
      show_spinner("migrando BD...") { %x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins) 
 
    else
      puts "voçê não está em modo de desenvolvimento"
    end
  end



  desc "Cadastra as Moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Moedas...") do
      coins =[
                {
                  description: "Biticoin",
                  acronym: "BTC",
                  url_image: " https://www.freepnglogos.com/uploads/bitcoin-png/bitcoin-all-about-bitcoins-9.png",
                  mining_type: MiningType.find_by(acronym: 'PoW')
                },

                {
                  description: "Ethereum",
                  acronym: "ETH",
                  url_image: "https://satang.zendesk.com/hc/article_attachments/360052756911/mceclip0.png ",
                  mining_type: MiningType.all.sample
                },

                {
                  description: "Dash",
                  acronym: "DASH",
                  url_image: "https://en.bitcoinwiki.org/upload/en/images/5/55/Dash.png ",
                  mining_type: MiningType.all.sample
                },

                { 
                  description: "IOTA",
                  acronym: "IOT",
                  url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1720.png",
                  mining_type: MiningType.all.sample
                },

                {
                  description: "ZCash",
                  acronym: "ZEC",
                  url_image: "https://assets.coingecko.com/coins/images/486/large/circle-zcash-color.png",
                  mining_type: MiningType.all.sample
                }
              ]

        coins.each do |coin|
          Coin.find_or_create_by!(coin)
        end
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("cadastrando tipos de mineração") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of CApacity", acronym: "PoC"}
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private

  def 
    show_spinner (msg_start, msg_end = "concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end


       
       
