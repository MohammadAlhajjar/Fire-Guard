<?php

namespace App\Controller;

use App\Constant\EmergencyRequestStatus;
use App\Constant\UserGender;
use App\Constant\FireStatusType;
use App\Service\RestHelperService;
use App\Service\UserService;
use Doctrine\ORM\EntityManagerInterface;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\Translation\TranslatorInterface;

#[Route('/api/options')]
class OptionController extends RestController
{
    private TranslatorInterface $translator;

    public function __construct(
        RestHelperService      $rest,
        EntityManagerInterface $em,
        UserService $userService,
        TranslatorInterface $translator
    ) {
        parent::__construct($rest, $em);
        $this->translator = $translator;
    }

    /**
     * Get Gender Type.
     * @OA\Tag(name="Options")
     * @OA\Response(
     *     response=200,
     *     description="Returns Gender Types.",
     *     @OA\JsonContent(
     *             @OA\Property(property="success",type="boolean"),
     *             @OA\Property(property="data",type="array",
     *                  @OA\Items(
     *                  @OA\Property(property="label",type="string",example="Pending"),
     *                  @OA\Property(property="value",type="string",example="PENDING"),
     *                  )
     *              )
     *      )
     * )
     * @OA\Parameter(ref="#components/parameters/locale")
     * @Security(name="Bearer")
     * @return Response
     */
    #[Route('/users/gender/types', methods: ["GET"])]
    public function getGenderTypes(): Response
    {
        $data = UserGender::getOptions($this->translator);

        $this->rest->succeeded()->setData($data);

        return $this
            ->viewResponse(
                $this->rest->getResponse(),
                Response::HTTP_OK
            );
    }
    
    /**
    * Get Fire Status Type.
    * @OA\Tag(name="Options")
    * @OA\Response(
    *     response=200,
    *     description="Returns Fire Status Types.",
    *     @OA\JsonContent(
    *             @OA\Property(property="success",type="boolean"),
    *             @OA\Property(property="data",type="array",
    *                  @OA\Items(
    *                  @OA\Property(property="label",type="string",example="Pending"),
    *                  @OA\Property(property="value",type="string",example="PENDING"),
    *                  )
    *              )
    *      )
    * )
    * @OA\Parameter(ref="#components/parameters/locale")
    * @Security(name="Bearer")
    * @return Response
    */
    #[Route('/fires/status/types', methods: ["GET"])]
    public function getFireTypes(): Response
    {
        $data = FireStatusType::getOptions($this->translator);

        $this->rest->succeeded()->setData($data);

        return $this
            ->viewResponse(
                $this->rest->getResponse(),
                Response::HTTP_OK
            );
    }
    
    /**
    * Get Emergency Request Status Type.
    * @OA\Tag(name="Options")
    * @OA\Response(
    *     response=200,
    *     description="Returns Emergency Request Status Types.",
    *     @OA\JsonContent(
    *             @OA\Property(property="success",type="boolean"),
    *             @OA\Property(property="data",type="array",
    *                  @OA\Items(
    *                  @OA\Property(property="label",type="string",example="Done"),
    *                  @OA\Property(property="value",type="string",example="DONE"),
    *                  )
    *              )
    *      )
    * )
    * @OA\Parameter(ref="#components/parameters/locale")
    * @Security(name="Bearer")
    * @return Response
    */
    #[Route('/emergency-requests/status', methods: ["GET"])]
    public function getEmergencyRequestStatus(): Response
    {
        $data = EmergencyRequestStatus::getOptions($this->translator);

        $this->rest->succeeded()->setData($data);

        return $this
            ->viewResponse(
                $this->rest->getResponse(),
                Response::HTTP_OK
            );
    }
}
