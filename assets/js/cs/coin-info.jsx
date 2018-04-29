// Attribution -> https://sabe.io/demos/cryptocurrency-ticker
import React from "react";
import ReactDOM from "react-dom";
import { Button } from "reactstrap";
import axios from "axios";

export default function run_coin(coinPage) {
  ReactDOM.render(<CryptoCoin />, coinPage);
}
class CryptoCoin extends React.Component {
  constructor(props) {
    console.log("in here");
    super(props);
    this.state = {
      data: [
        {
          id: "",
          name: "",
          symbol: "",
          rank: "",
          price_usd: "",
          price_btc: "",
          market_cap_usd: "",
          available_supply: "",
          total_supply: "",
          max_supply: "",
          percent_change_1h: "",
          percent_change_24h: "",
          percent_change_7d: "",
          last_updated: ""
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
    var path1 = "https://api.coinmarketcap.com/v1/ticker/" + coinName + "/";
    axios
      .get(path1)
      .then(response => {
        console.log(response.data);
        this.setState({ data: response.data });
      })
      .catch(err => console.log(err));
  }
  gotView(result) {
    this.setstate({ data: result });
  }
  render() {
    return (
      <div>
        <PrintCards coin={this.state.data} />
      </div>
    );
  }
}

class PrintCards extends React.Component {
  returnCard(coin) {
    var source = "/images/" + coin.id + "-symbol.png";
    return (
      <div>
        <h3 className="text"> Symbol: {coin.symbol}</h3>
        <div className="text">
          <p>Name: {coin.id}</p>
        </div>
        <div className="text">
          <p>Price in USD: {coin.price_usd} </p>
        </div>
        <div className="text">
          <p>Price in BTC: {coin.price_btc} </p>
        </div>
        <div className="text">
          <p>Market Cap Used: {coin.market_cap_usd} </p>
        </div>
        <div className="text">
          <p>Available Supply: {coin.available_supply} </p>
        </div>
        <div className="text">
          <p>Total Supply: {coin.total_supply} </p>
        </div>
        <div className="text">
          <p>Max Supply: {coin.max_supply} </p>
        </div>
        <div className="text">
          <p>% Change Hour: {coin.percent_change_1h} </p>
        </div>
        <div className="text">
          <p>% Change Day: {coin.percent_change_24h} </p>
        </div>
        <div className="text">
          <p>% Change Week:{coin.percent_change_7d} </p>
        </div>
      </div>
    );
  }
  render() {
    return <div>{this.returnCard(this.props.coin[0])}</div>;
  }
}
