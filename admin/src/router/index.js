import Vue from 'vue'
import Router from 'vue-router'
import Main from '@/components/main/Main'
import BangumiEdit from '@/components/bangumi/BangumiEdit'
import BangumiList from '@/components/bangumi/BangumiList'
import GuomanEdit from '@/components/guoman/GuomanEdit'
import GuomanList from '@/components/guoman/GuomanList'
import TheaterEdit from '@/components/theater/TheaterEdit'
import TheaterList from '@/components/theater/TheaterList'
import FilmTVEdit from '@/components/filmtv/FilmTVEdit'
import FilmTVList from '@/components/filmtv/FilmTVList'
import UserinfoEdit from '@/components/userinfo/UserinfoEdit'
import UserinfoList from '@/components/userinfo/UserinfoList'

import Test from '@/components/test'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'main',
      component: Main,
      children:[
        {path:'/bangumi/create',component: BangumiEdit},
        {path:'/bangumi/eidt/:id',component: BangumiEdit,props:true},
        {path:'/bangumi/list',component: BangumiList},

        {path:'/guoman/create',component: GuomanEdit},
        {path:'/guoman/eidt/:id',component: GuomanEdit,props:true},
        {path:'/guoman/list',component: GuomanList},

        {path:'/theater/create',component: TheaterEdit},
        {path:'/theater/eidt/:id',component: TheaterEdit,props:true},
        {path:'/theater/list',component: TheaterList},

        {path:'/filmtv/create',component: FilmTVEdit},
        {path:'/filmtv/eidt/:id',component: FilmTVEdit,props:true},
        {path:'/filmtv/list',component: FilmTVList},
        
        {path:'/userinfo/create',component: UserinfoEdit},
        {path:'/userinfo/eidt/:id',component: UserinfoEdit,props:true},
        {path:'/userinfo/list',component: UserinfoList},
      ]
    },
    {
      path:'/test',
      component: Test
    }
  ]
})
