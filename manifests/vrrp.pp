cnos_vrrp{ '1' :
         ensure => 'present', 
         prio =>  100,
         vr_id =>  1,
         if_name =>  'Ethernet1/1',
         track_if =>  'Ethernet1/2',
         preempt =>  'no',
         admin_state =>  'down',
         ip_addr =>  '1.1.1.254',
         switch_back_delay =>  1,
         accept_mode =>  'no',
         v2_compt =>  'no',
         ad_intvl =>  100
}
