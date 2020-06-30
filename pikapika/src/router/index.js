import Vue from 'vue'
import Router from 'vue-router'

import Layout from '@/components/layout/Layout'
import Userinfo from '@/components/userinfo/Userinfo'
import Home from '@/components/home/Home'
import Login from '@/components/login/Login'
import RegisterPage from '@/components/registerPage/RegisterPage'
import Register from '@/components/register/Register'
import FindPsw from '@/components/findPsw/FindPsw'
import Verify from '@/components/findPsw/step/Verify'
import Reset from '@/components/findPsw/step/Reset'
import Success from '@/components/findPsw/step/Success'
import General from '@/components/general/General'
import News from '@/components/news/News'
import NewsList from '@/components/newsList/NewsList'
import NewsDetail from '@/components/newsDetail/NewsDetail'
import RankPage from '@/components/rankPage/RankPage'
import PlayInfo from '@/components/playInfo/PlayInfo'
import FanInfo from '@/components/fanInfo/FanInfo'
import Player from '@/components/common/player/Player'
import ErrorPage from '@/components/common/errorPage/ErrorPage'

Vue.use(Router)

export default new Router({
  mode:'history',
  routes: [
    {
      path: '',
      redirect: '/home'
    },

    {
      path: '/login',
      name:'login',
      component: Login,
    },
    {
      path: '/register',
      component: RegisterPage,
      children: [
        {
          path: '',
          component: Register
        },
        // {
        //   path: 'success',
        //   name: 'success',
        //   component: Success
        // },
        {
          path: 'findpassword',
          component: FindPsw,
          children: [
            {
              path: '',
              name: 'verify',
              component: Verify
            },
            {
              path: 'reset',
              name: 'reset',
              component: Reset
            },
            {
              path: 'success',
              name: 'success',
              component: Success
            }
          ]
        },
      ]
    },
    
    {
      path: '',
      component: Layout,
      children: [
        {
          path: '/userinfo',
          name: 'userinfo',
          component: Userinfo
        },
        {
          path: '/home',
          name: 'home',
          component: Home
        },
        {
          path: '/playinfo',
          // name: 'playinfo',
          component: PlayInfo,
          children: [
            {
              path: '',
              name: 'faninfo',
              component: FanInfo,
            },
            {
              path: 'play/:type_id/:film_id/:episode',
              name: 'play',
              component: Player,
              props:true
            }
          ]
        },
        {
          path: '/information/:id',
          // name: 'news',
          component: News,
          children: [
            {
              path: '',
              name: 'list',
              component: NewsList
            },
            {
              path: 'detail',
              name: 'detail',
              component: NewsDetail
            },
          ]
        },
        {
          path: '/rankpage',
          name: 'rankpage',
          component: RankPage
        },
        {
          path: '/type/:id',
          name: 'general',
          component: General
        },
        {
          path: '*',
          component: ErrorPage
        }
      ]
    },

    // {
    //   path: '*',
    //   component: ErrorPage
    // }
  ]
})
