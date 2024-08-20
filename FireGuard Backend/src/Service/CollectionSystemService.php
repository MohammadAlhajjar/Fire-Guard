<?php

namespace App\Service;

use App\Service\CenterService;
use App\Service\FireService;
use App\Service\ForestService;
use App\Service\DeviceService;
use Doctrine\ORM\EntityManagerInterface;
use Knp\Component\Pager\Pagination\PaginationInterface;
use Knp\Component\Pager\PaginatorInterface;
use Doctrine\ORM\Query;

class CollectionSystemService
{
    private CenterService $centerService;
    private FireService   $fireService;
    private ForestService $forestService;
    private DeviceService $deviceService;
    
    public function __construct(CenterService $centerService, FireService $fireService, ForestService $forestService, DeviceService $deviceService) 
    {
        $this->centerService = $centerService;
        $this->fireService   = $fireService;
        $this->forestService = $forestService;
        $this->deviceService = $deviceService;
    }
    
    public function getCollectionSystem() 
    {
        $centers = $this->centerService->findAll();
        $fires = $this->fireService->findAll();
        $forestes = $this->forestService->findAll();
        $devices = $this->deviceService -> findAll();
        
        return [
            'centers' => $centers,
            'fires' => $fires,
            'forestes' => $forestes,
            'devices' => $devices
        ];
    }
}