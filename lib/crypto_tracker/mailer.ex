#Attribution -> https://github.com/mailman/mailman 
defmodule CryptoTracker.Mailer do
    def deliver(email) do
        Mailman.deliver(email, config())
    end
  
    def config do
        %Mailman.Context{
          config: %Mailman.SmtpConfig{
            relay: "smtp your host",
            username: "email",  #enter your email here
            password: "password", # enter your password here
            port: 587,
            tls: :always,
            auth: :always,
          },
          composer: %Mailman.EexComposeConfig{}
        }
    end

end
