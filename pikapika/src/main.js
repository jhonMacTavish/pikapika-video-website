// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue';
import App from './App';
import router from './router';
import store from './store';
import ElementUI from 'element-ui';

import 'element-ui/lib/theme-chalk/index.css';
import './assets/css/style.css';

import Banner from '@/components/banner/Banner';
import Navbar from '@/components/navbar/Navbar';
import Carousel from '@/components/carousel/Carousel';
import Ad from '@/components/ad/Ad';
import Block from '@/components/block/Block';
import FanTimeTb from '@/components/fanTimeTb/FanTimeTb';
import Leaderboard from '@/components/leaderboard/Leaderboard';
import Footer from '@/components/footer/Footer';
import HotPlay from '@/components/hotPlay/HotPlay';
import Comment from '@/components/comment/Comment';

import FanBox from '@/components/common/fanBox/FanBox';
import Card from '@/components/common/card/Card';
import BlockHeader from '@/components/common/blockHeader/BlockHeader';
import FilterBlock from '@/components/common/filterBlock/FilterBlock';
import SearchBar from '@/components/common/searchBar/SearchBar';
import ShopWindow from '@/components/common/shopWindow/ShopWindow';
import NewsItem from '@/components/common/newsItem/NewsItem';
import RankItem from '@/components/common/rankItem/RankItem';
import Episode from './components/common/episode/Episode';
import CommentItem from './components/common/commentItem/CommentItem';

Vue.component(Banner.name,Banner);
Vue.component(Navbar.name,Navbar);
Vue.component(Carousel.name,Carousel);
Vue.component(Ad.name,Ad);
Vue.component(Block.name,Block);
Vue.component(Card.name,Card);
Vue.component(FanTimeTb.name,FanTimeTb);
Vue.component(FanBox.name,FanBox);
Vue.component(Leaderboard.name,Leaderboard);
Vue.component(BlockHeader.name,BlockHeader);
Vue.component(Footer.name,Footer);
Vue.component(HotPlay.name,HotPlay);
Vue.component(SearchBar.name,SearchBar);
Vue.component(FilterBlock.name,FilterBlock);
Vue.component(ShopWindow.name,ShopWindow);
Vue.component(NewsItem.name,NewsItem);
Vue.component(RankItem.name,RankItem);
Vue.component(Episode.name,Episode);
Vue.component(Comment.name,Comment);
Vue.component(CommentItem.name,CommentItem);

Vue.use(ElementUI);

Vue.config.productionTip = true;
import http from './util/http';
Vue.prototype.$http=http;

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})
