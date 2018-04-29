// Attribution -> https://sabe.io/demos/cryptocurrency-ticker
import React from "react";
import ReactDOM from "react-dom";
import { Button } from "reactstrap";
import axios from "axios";

export default function run_mycur(mycur, channel) {
  ReactDOM.render(<MyCur channel={channel} />, mycur);
}
class MyCur extends React.Component {
  constructor(props) {
    console.log("in here");
    super(props);
    this.currency_list = [];
    this.channel = props.channel;
    this.channel.join();
    this.state = {
      data: [
        {
          id: "bitcoin",
          name: "Bitcoin",
          symbol: "BTC",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "ethereum",
          name: "Ethereum",
          symbol: "ETH",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "litecoin",
          name: "Litecoin",
          symbol: "LTC",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "ripple",
          name: "Ripple",
          symbol: "XRP",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "stellar",
          name: "Stellar",
          symbol: "XLM",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "eos",
          name: "EOS",
          symbol: "EOS",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "cardano",
          name: "Cardano",
          symbol: "ADA",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "iota",
          name: "IOTA",
          symbol: "MIOTA",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "neo",
          name: "NEO",
          symbol: "NEO",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "dash",
          name: "Dash",
          symbol: "DASH",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "tron",
          name: "TRON",
          symbol: "TRX",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "tether",
          name: "Tether",
          symbol: "USDT",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "vechain",
          name: "VeChain",
          symbol: "VEN",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "omisego",
          name: "OmiseGO",
          symbol: "OMG"
        },
        {
          id: "qtum",
          name: "Qtum",
          symbol: "QTUM",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        },
        {
          id: "binance-coin",
          name: "Binance Coin",
          symbol: "BNB",
          price_usd: "1",
          percent_change_1h: "0",
          percent_change_24h: "0",
          percent_change_7d: "0"
        }
      ]
    };
  }
  componentDidMount() {
    this.fetchCryptocurrencyData();
    this.interval = setInterval(
      () => this.fetchCryptocurrencyData(),
      10 * 1000
    );
  }
  fetchCryptocurrencyData() {
    this.channel
      .push("getUserCoins", { user_id: userId })
      .receive("ok", resp => {
        this.currency_list = resp.currency_list;
      });
    console.log(this.currency_list);
    this.channel.push("getAllCoins", {}).receive("ok", response => {
      var wanted = [
        "bitcoin",
        "ethereum",
        "litecoin",
        "ripple",
        "stellar",
        "eos",
        "cardano",
        "iota",
        "neo",
        "dash",
        "tron",
        "tether",
        "vechain",
        "omisego",
        "qtum",
        "binance-coin"
      ];
      var result = response.result.filter(currency =>
        wanted.includes(currency.id)
      );
      this.setState({ data: result });
    });
  }
  gotView(result) {
    this.setstate({ data: result });
  }
  render() {
    return (
      <div>
        <PrintCards coins={this.state.data} list={this.currency_list} />
      </div>
    );
  }
}

class PrintCards extends React.Component {
  returnCard(coin) {
    var source = "/images/" + coin.id + "-symbol.png";
    var path = "/coin/" + coin.id;
    if (this.props.list.indexOf(coin.id) >= 0) {
      return (
        <div className="card bg-info">
          <div className="text-center">
            <div className="card-body">
              <h5 className="card-title">{coin.symbol}</h5>
              <h5 className="card-title">{coin.id}</h5>
              <strong>
                {" "}
                <p className="card-text text-danger">
                  USD: {coin.price_usd}${" "}
                </p>{" "}
              </strong>
              <a href={path} className="btn btn-primary">
                Know More!
              </a>
            </div>
          </div>
        </div>
      );
    } else {
      return null;
    }
  }
  // <div>

  render() {
    return (
      <div>
        {this.returnCard(this.props.coins[0])}
        {this.returnCard(this.props.coins[1])}
        {this.returnCard(this.props.coins[2])}
        {this.returnCard(this.props.coins[3])}
        {this.returnCard(this.props.coins[4])}
        {this.returnCard(this.props.coins[5])}
        {this.returnCard(this.props.coins[6])}
        {this.returnCard(this.props.coins[7])}
        {this.returnCard(this.props.coins[8])}
        {this.returnCard(this.props.coins[9])}
        {this.returnCard(this.props.coins[10])}
        {this.returnCard(this.props.coins[11])}
        {this.returnCard(this.props.coins[12])}
        {this.returnCard(this.props.coins[13])}
        {this.returnCard(this.props.coins[14])}
        {this.returnCard(this.props.coins[15])}
      </div>
    );
  }
}
