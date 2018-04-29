// Attribution -> https://sabe.io/demos/cryptocurrency-ticker
//logos Attribution -> https://github.com/cjdowner/cryptocurrency-icons
import React from "react";
import ReactDOM from "react-dom";
import { Button } from "reactstrap";

export default function run_all(root, channel) {
  ReactDOM.render(<Crypto channel={channel} />, root);
}

class Crypto extends React.Component {
  constructor(props) {
    super(props);
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
      20 * 1000
    );
  }
  fetchCryptocurrencyData() {
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
        <PrintCards coins={this.state.data} />
      </div>
    );
  }
}

class PrintCards extends React.Component {
  returnCard(coin) {
    var source = "/images/" + coin.id + "-symbol.png";
    var path = "/coin/" + coin.id;
    return (
      <div className="card">
        <div className="text-center">
          <img
            className="card-image img-fluid"
            src={source}
            alt="Card image cap"
          />
          <div className="card-body">
            <h5 className="card-title">{coin.symbol}</h5>
            <h5 className="card-title">{coin.id}</h5>
            <p className="card-text text-danger">USD: {coin.price_usd}$ </p>
            <a href={path} className="btn btn-primary">
              Know More!
            </a>
          </div>
        </div>
      </div>
    );
  }
  render() {
    return (
      <div className="container-fluid">
        <div className="row">
          <div className="col-sm">{this.returnCard(this.props.coins[0])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[1])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[2])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[3])}</div>
        </div>
        <div className="row">
          <div className="col-sm">{this.returnCard(this.props.coins[4])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[5])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[6])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[7])}</div>
        </div>
        <div className="row">
          <div className="col-sm">{this.returnCard(this.props.coins[8])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[9])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[10])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[11])}</div>
        </div>
        <div className="row">
          <div className="col-sm">{this.returnCard(this.props.coins[12])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[13])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[14])}</div>
          <div className="col-sm">{this.returnCard(this.props.coins[15])}</div>
        </div>
      </div>
    );
  }
}
